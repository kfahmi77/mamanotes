import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/common/style.dart';

class MyDiaryController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotes() async* {
    final uid = _auth.currentUser?.uid;
    yield* _firestore
        .collection('catatanku')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  void deleteNote(String docId) {
    try {
      Get.defaultDialog(
        title: 'Delete Note',
        titlePadding: const EdgeInsets.all(16),
        content: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Anda yakin untuk menghapus data ini?'),
        ),
        actions: [
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(red),
              foregroundColor: MaterialStateProperty.all(white),
            ),
            onPressed: () async {
              Get.back();
              await _firestore.collection('catatanku').doc(docId).delete();
            },
            child: const Text('Ya,Hapus'),
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(white),
            ),
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
        ],
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Error', 'Gagal hapus data');
    }
  }
}
