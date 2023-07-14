import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddTahunPertamaAnakController extends GetxController {
  final fotoTahunPertamaAnak = Rx<File?>(null);
  String _downloadURL = '';
  XFile? pickedImage;

  void pickFotoTahunPertamaAnak(ImageSource source) async {
    pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      fotoTahunPertamaAnak.value = File(pickedImage!.path);
      update();
    } else {
      fotoTahunPertamaAnak.value = null;
    }
  }

  Future<void> uploadImage(String anakId, String dudukAnakId) async {
    if (fotoTahunPertamaAnak.value == null) {
      Get.snackbar('Gagal', 'Foto masih sama seperti sebelumnya');
      return;
    }

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      String downloadURL =
          await uploadImageToFirebaseStorage(fotoTahunPertamaAnak.value!.path);
      _downloadURL = downloadURL;

      // Menyimpan URL gambar baru ke Firestore
      await saveImageUrlToFirestore(_downloadURL, anakId, dudukAnakId);

      print('URL unduhan gambar: $_downloadURL');

      Get.back();
      Get.back();
      Get.back();
      Get.snackbar('Berhasil', 'Data Tahun Pertama Anak  berhasil ditambahkan');
    } catch (e) {
      print('Error updating image: $e');
      Get.back();
      Get.snackbar('Gagal', 'Terjadi kesalahan saat mengupdate gambar');
    }
  }

  Future<String> uploadImageToFirebaseStorage(String imagePath) async {
    // Menghasilkan nama unik untuk file gambar yang akan diunggah
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Mendapatkan referensi ke Firebase Storage
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    // Mengunggah gambar ke Firebase Storage
    await storageRef.putFile(File(imagePath));

    // Mendapatkan URL unduhan gambar dari Firebase Storage
    String downloadURL = await storageRef.getDownloadURL();

    return downloadURL;
  }

  Future<void> saveImageUrlToFirestore(
      String imageUrl, String anakId, tahunPertamaAnakId) async {
    try {
      // Mendapatkan referensi koleksi di Firestore (misalnya, koleksi 'images')
      DocumentReference<Map<String, dynamic>> imagesRef = FirebaseFirestore
          .instance
          .collection('anak')
          .doc(anakId)
          .collection('jurnal_anak')
          .doc(tahunPertamaAnakId);

      // Menambahkan data gambar ke Firestore
      await imagesRef.set({
        'documentId': anakId,
        'tahunPertamaAnakId': tahunPertamaAnakId,
        'foto_tahun_pertama_anak': imageUrl
      });
      debugPrint('URL gambar berhasil disimpan di Firestore');
    } catch (e) {
      debugPrint(
          'Terjadi kesalahan saat menyimpan URL gambar di Firestore: $e');
    }
  }
}
