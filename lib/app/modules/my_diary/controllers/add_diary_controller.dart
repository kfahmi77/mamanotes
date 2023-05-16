import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';

import '../../../routes/app_pages.dart';

class AddDiaryController extends GetxController {
  final titleC = TextEditingController();
  final descriptionC = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  void addNote() async {
    if (titleC.text.isNotEmpty && descriptionC.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      try {
        await _firestore.collection('catatanku').add({
          'judul': titleC.text,
          'deskripsi': descriptionC.text,
          'tanggal': DateTime.now(),
          'uid': _auth.currentUser?.uid,
        });
        isLoading.value = false;
        Get.defaultDialog(
          title: 'Sukses',
          middleText: 'Catatan berhasil disimpan',
          actions: [
            OutlinedButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('Oke'),
            ),
          ],
        );
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) print(e);
        Get.snackbar('Error', 'Failed to save data!');
      }
    } else {
      Get.snackbar(
          backgroundColor: background, 'Perhatian', 'Data harus diisi semua!');
    }
  }
}
