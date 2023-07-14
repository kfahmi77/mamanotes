import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/tahun_pertama_anak_model.dart';

class EditTahunPertamaAnakController extends GetxController {
  final fotoTahunPertamaAnak = Rx<File?>(null);
  String _downloadURL = '';
  XFile? pickedImage;

  void init(TahunPertamaAnakModel tahunPertamaAnak) {
    if (tahunPertamaAnak.imageUrl.isNotEmpty) {
      fotoTahunPertamaAnak.value = File(tahunPertamaAnak.imageUrl);
      _downloadURL =
          tahunPertamaAnak.imageUrl; // Tugaskan nilai URL gambar sebelumnya
    }
  }

  void pickFotoBulanPertamaAnak(ImageSource source) async {
    pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      fotoTahunPertamaAnak.value = File(pickedImage!.path);
      update();
    } else {
      fotoTahunPertamaAnak.value = null;
    }
  }

  Future<void> updateImage(String anakId, String bulanPertamaAnakId) async {
    if (fotoTahunPertamaAnak.value == null || !fotoTahunPertamaAnak.value!.existsSync()) {
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
      // Mendapatkan URL gambar sebelumnya

      String previousImageUrl = '';
      print('URL gambar sebelumnya: $previousImageUrl');
      if (_downloadURL.isNotEmpty) {
        previousImageUrl = _downloadURL;
      }

      // Upload gambar baru ke Firebase Storage
      String downloadURL =
          await uploadImageToFirebaseStorage(fotoTahunPertamaAnak.value!.path);
      _downloadURL = downloadURL;

      // Menghapus gambar sebelumnya dari Firebase Storage jika ada
      if (previousImageUrl.isNotEmpty) {
        await deleteImageFromFirebaseStorage(previousImageUrl);
      }

      // Menyimpan URL gambar baru ke Firestore
      await saveImageUrlToFirestore(_downloadURL, anakId, bulanPertamaAnakId);

      print('URL unduhan gambar: $_downloadURL');

      Get.back();
      Get.back();
      Get.back();
      Get.snackbar('Berhasil', 'Data  Tahun Pertama Anak  berhasil diupdate');
    } catch (e) {
      print('Error updating image: $e');
      Get.back();
      Get.snackbar('Gagal', 'Terjadi kesalahan saat mengupdate gambar');
    }
  }

  Future<void> deleteImageFromFirebaseStorage(String imageUrl) async {
    try {
      // Menghapus file gambar dari Firebase Storage berdasarkan URL
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();
      print('Gambar sebelumnya berhasil dihapus dari Firebase Storage');
    } catch (e) {
      print(
          'Terjadi kesalahan saat menghapus gambar dari Firebase Storage: $e');
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
      String imageUrl, String anakId, bulanPertamaAnakId) async {
    try {
      // Mendapatkan referensi koleksi di Firestore (misalnya, koleksi 'images')
      DocumentReference<Map<String, dynamic>> imagesRef = FirebaseFirestore
          .instance
          .collection('anak')
          .doc(anakId)
          .collection('jurnal_anak')
          .doc(bulanPertamaAnakId);

      // Menambahkan data gambar ke Firestore
      await imagesRef.set({
        'documentId': anakId,
        'bulanPertamaAnakId': bulanPertamaAnakId,
        'foto_bulan_pertama_anak': imageUrl
      });
      debugPrint('URL gambar berhasil disimpan di Firestore');
    } catch (e) {
      debugPrint(
          'Terjadi kesalahan saat menyimpan URL gambar di Firestore: $e');
    }
  }
}
