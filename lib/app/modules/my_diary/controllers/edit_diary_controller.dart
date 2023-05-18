import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDiaryController extends GetxController {
  final titleC = TextEditingController();
  final descriptionC = TextEditingController();

  final _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Future<Map<String, dynamic>?> getNoteById(String docId) async {
    try {
      final doc = await _firestore.collection('catatanku').doc(docId).get();
      return doc.data();
    } catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  void editNote(String docId) async {
    if (titleC.text.isNotEmpty && descriptionC.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      try {
        await _firestore.collection('catatanku').doc(docId).update({
          'judul': titleC.text,
          'deskripsi': descriptionC.text,
        });
        Get.defaultDialog(
          title: 'Sukses',
          middleText: 'Data berhasil diupdate',
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
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        if (kDebugMode) print(e);
        Get.snackbar('Error', 'Gagal edit data!');
      }
    } else {
      Get.snackbar('Error', 'Data harus diisi semua!');
    }
  }
}
