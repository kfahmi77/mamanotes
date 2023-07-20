import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddKataPertamaAnakController extends GetxController {
  Rx<File?> audioFile = Rx<File?>(null);
  RxBool isUploading = false.obs;
  TextEditingController kataPertama = TextEditingController();

  // Fungsi untuk memilih file audio dari perangkat
  Future<void> selectAudio() async {
    // Menggunakan package file_picker untuk memilih file audio
    // Pastikan telah mengimpor package file_picker di pubspec.yaml
    // dan menginisialisasikannya sebelumnya.

    // Melakukan pemilihan file audio
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    audioFile.value = File(result!.files.single.path!);
  }

  // Fungsi untuk mengunggah file audio ke Firebase Storage dan menyimpan URL-nya di Firestore
  Future<void> uploadAudio(String documenId, String kataPertamaAnakId) async {
    const int maxSizeInBytes = 5 * 1024 * 1024;
    if (audioFile.value == null || kataPertama.text == '') {
      Get.snackbar(
        'Error',
        'Pilih file audio dan masukkan kata pertama',
      );
      if (audioFile.value!.lengthSync() > maxSizeInBytes) {
        Get.snackbar(
          'Error',
          'Ukuran file audio melebihi 5 MB',
        );
      }
      return;
    }

    isUploading.value = true;

    try {
      // Membuat referensi ke Firebase Storage
      final Reference storageRef = FirebaseStorage.instance.ref().child(
          'jurnal_anak/kata_pertama/${DateTime.now().millisecondsSinceEpoch}.mp3');

      // Mengunggah file audio ke Firebase Storage
      final UploadTask uploadTask = storageRef.putFile(audioFile.value!);

      // Menunggu hingga proses pengungahan selesai
      final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});

      // Mendapatkan URL download file audio dari Firebase Storage
      final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      // Mengakses koleksi 'audio' di Firestore
      final DocumentReference<Map<String, dynamic>> audioCollection =
          FirebaseFirestore.instance
              .collection('anak')
              .doc(documenId)
              .collection('jurnal_anak')
              .doc(kataPertamaAnakId);

      // Menyimpan URL audio ke Firestore
      await audioCollection.set({
        'documentId': documenId,
        'kataPertamaId': kataPertamaAnakId,
        'suara': downloadUrl,
        'kata_pertama': kataPertama.text
      });

      Get.back();
      Get.back();
      Get.snackbar(
        'Sukses',
        'Data berhasil ditambahkan',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isUploading.value = false;
  }
}
