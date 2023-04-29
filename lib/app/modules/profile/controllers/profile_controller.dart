import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Users;
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Users.User? user = Users.FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot<Map<String, dynamic>>> getDataUser() async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: user!.uid)
        .snapshots();
  }
}
