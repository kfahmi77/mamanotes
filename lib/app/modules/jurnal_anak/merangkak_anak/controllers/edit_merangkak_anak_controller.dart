import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/merangkak_anak_model.dart';

class EditMerangkakAnakController extends GetxController {
  final fotoGigiAnak = Rx<File?>(null);
  String _downloadURL = '';
  XFile? pickedImage;

  void init(MerangkakAnakModel merangkakAnak) {
    if (merangkakAnak.imageUrl.isNotEmpty) {
      fotoGigiAnak.value = File(merangkakAnak.imageUrl);
      _downloadURL =
          merangkakAnak.imageUrl; // Tugaskan nilai URL gambar sebelumnya
    }
  }

  void pickFotoGigiAnak(ImageSource source) async {
    pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      fotoGigiAnak.value = File(pickedImage!.path);
      update();
    } else {
      fotoGigiAnak.value = null;
    }
  }

  Future<void> updateImage(String anakId, String berdiriAnakId) async {
    if (fotoGigiAnak.value == null || !fotoGigiAnak.value!.existsSync()) {
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
      debugPrint('URL gambar sebelumnya: $previousImageUrl');
      if (_downloadURL.isNotEmpty) {
        previousImageUrl = _downloadURL;
      }

      // Upload gambar baru ke Firebase Storage
      String downloadURL =
          await uploadImageToFirebaseStorage(fotoGigiAnak.value!.path);
      _downloadURL = downloadURL;

      // Menghapus gambar sebelumnya dari Firebase Storage jika ada
      if (previousImageUrl.isNotEmpty) {
        await deleteImageFromFirebaseStorage(previousImageUrl);
      }

      // Menyimpan URL gambar baru ke Firestore
      await saveImageUrlToFirestore(_downloadURL, anakId, berdiriAnakId);

      debugPrint('URL unduhan gambar: $_downloadURL');

      Get.back();
      Get.back();
      Get.back();
      Get.snackbar('Berhasil', 'Data  Anak Merangkak berhasil diupdate');
    } catch (e) {
      debugPrint('Error updating image: $e');
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
      debugPrint('Gambar sebelumnya berhasil dihapus dari Firebase Storage');
    } catch (e) {
      debugPrint(
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
      String imageUrl, String anakId, berdiriAnakId) async {
    try {
      // Mendapatkan referensi koleksi di Firestore (misalnya, koleksi 'images')
      DocumentReference<Map<String, dynamic>> imagesRef = FirebaseFirestore
          .instance
          .collection('anak')
          .doc(anakId)
          .collection('jurnal_anak')
          .doc(berdiriAnakId);

      // Menambahkan data gambar ke Firestore
      await imagesRef.set({
        'documentId': anakId,
        'merangkakAnakId': berdiriAnakId,
        'foto_merangkak_anak': imageUrl
      });
      debugPrint('URL gambar berhasil disimpan di Firestore');
    } catch (e) {
      debugPrint(
          'Terjadi kesalahan saat menyimpan URL gambar di Firestore: $e');
    }
  }
}
