import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../modules/dashboard/views/dashboard_view.dart';
import '../../modules/signup/controllers/signup_controller.dart';
import '../../routes/app_pages.dart';

class AuthController extends GetxController {
  // untuk cek kondisi ada auth atau tidak -> uid
  //  Null -> tidak ada user yang sedang login
  // uid -> ada user yang sedang login
  String? uid;

  late FirebaseAuth auth;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  late SignupController authC = Get.find<SignupController>();
  late GoogleSignIn _googleSignIn;
  final picker = ImagePicker();
  RxBool isLoading = false.obs;

  Rx<File?> image = Rx<File?>(null);
  Rx<GoogleSignInAccount?> googleSignInAccount = Rx<GoogleSignInAccount?>(null);

  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (userCredential.user!.emailVerified == true) {
        isLoading.value = false;
        Get.offAllNamed(Routes.dashboard);
        isLoading.value = false;
        Get.offAllNamed(Routes.dashboard);
      } else {
        isLoading.value = false;
        debugPrint('User not verified!');

        Get.defaultDialog(
          title: 'Emailmu belum terverifikasi',
          middleText: 'Apakah anda ingin dikirim lagi verifikasi email?',
          actions: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text('tidak'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // kirim ulang email verifikasi
                  await userCredential.user!.sendEmailVerification();
                  Get.back();
                  debugPrint('Successfully sent verification email');
                  Get.snackbar(
                    'Berhasil',
                    'Cek emailmu untuk verifikasi',
                  );
                } on FirebaseAuthException catch (e) {
                  Get.back();
                  if (e.code == 'too-many-requests') {
                    Get.snackbar(
                      'Error',
                      'Terlalu banyak request tunggu beberapa saat',
                    );
                  }
                }
              },
              child: const Text('Kirim lagi'),
            ),
          ],
        );
      }

      return {
        "error": false,
        "message": "Berhasil login.",
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return {
          "error": true,
          "message": "email / password salah",
        };
      }
      return {
        "error": true,
        "message": e.toString(),
      };
    } catch (e) {
      // Error general
      return {
        "error": true,
        "message": "Tidak dapat login.",
      };
    }
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<String> uploadImage(File file, String uid) async {
    Reference ref = _storage.ref().child("user/$uid.jpg");
    await ref.putFile(file);
    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadDefaultImage(String uid) async {
    String url = '';
    final ByteData bytes = await rootBundle.load('assets/images/daughter.png');
    final Uint8List data = bytes.buffer.asUint8List();

    final Reference ref = _storage.ref().child('user/$uid.jpg');
    final UploadTask task = ref.putData(data);

    await task.whenComplete(() async {
      url = await ref.getDownloadURL();
      image.value = null;
    });
    return url;
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String name) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String imageUrl = await (image.value != null
          ? uploadImage(image.value!, result.user!.uid)
          : uploadDefaultImage(result.user!.uid));
      result.user!.updateDisplayName(name);
      result.user!.updatePhotoURL(imageUrl);

      await _firestore.collection("users").doc(result.user!.uid).set({
        "name": name,
        "email": email,
        "imageUrl": imageUrl,
      });
      await result.user!.sendEmailVerification();

      return {
        "error": false,
        "message": "Berhasil daftar.",
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return {
          "error": true,
          "message": "email / password salah",
        };
      }
      return {
        "error": true,
        "message": e.toString(),
      };
    } catch (e) {
      // Error general
      return {
        "error": true,
        "message": "Tidak dapat daftar. ${e.toString()}",
      };
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      Get.offAll(() => const DashboardView());
    } catch (e) {
      print('Google sign in error: $e');
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();

      return {
        "error": false,
        "message": "Berhasil logout.",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      // Error general
      return {
        "error": true,
        "message": "Tidak dapat logout.",
      };
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });

    super.onInit();
  }
}
