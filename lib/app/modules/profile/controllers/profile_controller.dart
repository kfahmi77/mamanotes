import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot<Map<String, dynamic>>> getDataUser() async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: user!.uid)
        .snapshots();
  }

  @override
  void onInit() {
    debugPrint('user ${_auth.currentUser!.uid}');
    debugPrint('email ${_auth.currentUser!.email}');
    debugPrint('nama ${_auth.currentUser!.displayName}');
    debugPrint('foto ${_auth.currentUser!.photoURL}');
    super.onInit();
  }
}
