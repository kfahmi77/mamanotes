import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Users;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Users.User? user = Users.FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot<Map<String, dynamic>>> getDataUser() async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: user!.uid)
        .snapshots();
  }

  @override
  void onInit() {
    print('user ${_auth.currentUser!.uid}');
    print('email ${_auth.currentUser!.email}');
    print('nama ${_auth.currentUser!.displayName}');
    print('foto ${_auth.currentUser!.photoURL}');
    super.onInit();
  }
}
