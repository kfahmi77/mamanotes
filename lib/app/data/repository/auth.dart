import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mamanotes/app/modules/profile/controllers/profile_controller.dart';
import 'package:mamanotes/app/modules/signup/controllers/signup_controller.dart';

class AuthController extends GetxController {
  // untuk cek kondisi ada auth atau tidak -> uid
  //  Null -> tidak ada user yang sedang login
  // uid -> ada user yang sedang login
  String? uid;

  late FirebaseAuth auth;
  final firestore = FirebaseFirestore.instance;
  late SignupController authC = Get.find<SignupController>();

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

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      var hasil = await firestore.collection('users').doc(user!.uid).set(
          {'name': authC.nameController.text, 'email': email, 'uid': user.uid});
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
