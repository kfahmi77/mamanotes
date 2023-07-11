import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class AddMerangkakAnakController extends GetxController {
 final fotoMerangkakAnak = Rx<File?>(null);
  String _downloadURL = '';
  XFile? pickedImage;


  void pickFotoMerangkakAnak(ImageSource source) async {
    pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      fotoMerangkakAnak.value = File(pickedImage!.path);
      update();
    } else {
      fotoMerangkakAnak.value = null;
    }
  }

  Future<void> uploadImage(String anakId, String gigianAnakId) async {
    if (fotoMerangkakAnak.value == null) {
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
          await uploadImageToFirebaseStorage(fotoMerangkakAnak.value!.path);
      _downloadURL = downloadURL;


      // Menyimpan URL gambar baru ke Firestore
      await saveImageUrlToFirestore(_downloadURL, anakId, gigianAnakId);

      print('URL unduhan gambar: $_downloadURL');

      Get.back();
      Get.back();
      Get.back();
      Get.snackbar('Berhasil', 'Data Anak Merangkak berhasil ditambahkan');
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