import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Kolase2Controller extends GetxController {
  final RxList<String> imagePaths = List.generate(3, (_) => '').obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final ScreenshotController screenshotController = ScreenshotController();
  final firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? auth = FirebaseAuth.instance.currentUser;
  final TextEditingController captionController = TextEditingController();
  var isSaving = false.obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  Future<void> getImageFromGallery(int index) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePaths[index] = pickedFile.path;
    }
  }

  Future<void> saveData() async {
    if (isSaving.value) return;

    isSaving.value = true;

    try {
      await uploadScreenshot();
      Get.snackbar(
        'Berhasil',
        'Kolase berhasil disimpan',
      );
    } catch (error) {
      Get.snackbar(
        'Gagal',
        'Terjadi kesalahan saat menyimpan kolase',
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> uploadScreenshot() async {
    if (captionController.text.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Caption tidak boleh kosong',
      );
      return;
    }
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      String fileName = '${DateTime.now()}.png';
      firebase_storage.Reference ref =
          firebaseStorage.ref().child('kenangan/$fileName');
      await ref.putData(imageBytes);

      String downloadURL = await ref.getDownloadURL();
      print('Screenshot URL: $downloadURL');

      // Simpan URL ke Firestore dengan nama koleksi anak
      var hasil = await firestore.collection("kenangan").add({
        "kenanganId": "",
        "image_url": downloadURL,
        "uid": auth!.uid,
        "caption": captionController.text,
        "create_at": selectedDate.value,
      });
      await firestore.collection("kenangan").doc(hasil.id).update({
        "kenanganId": hasil.id,
      });

      // Kembali ke halaman sebelumnya
      Get.back();
      Get.back();
      Get.back();
    }
  }
}
