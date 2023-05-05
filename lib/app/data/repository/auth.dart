import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamanotes/app/modules/signup/controllers/signup_controller.dart';

class AuthController extends GetxController {
  // untuk cek kondisi ada auth atau tidak -> uid
  //  Null -> tidak ada user yang sedang login
  // uid -> ada user yang sedang login
  String? uid;

  late FirebaseAuth auth;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  late SignupController authC = Get.find<SignupController>();
  final picker = ImagePicker();

  Rx<File?> image = Rx<File?>(null);

  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);

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
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      print('No image selected.');
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

  Future<Map<String, dynamic>> logout() async {
    try {
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

    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });

    super.onInit();
  }
}
