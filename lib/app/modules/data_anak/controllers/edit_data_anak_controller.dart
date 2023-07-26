import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamanotes/app/data/common/style.dart';

import '../../home/models/anak_model.dart';

class EditDataAnakController extends GetxController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController panggilanController = TextEditingController();
  final TextEditingController tempatController = TextEditingController();
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<File?> fotoAnak = Rx<File?>(null);
  final RxBool isFormValid = true.obs;

  void init(AnakModel anak) {
    namaController.text = anak.namaLengkap;
    panggilanController.text = anak.namaPanggilan;
    tempatController.text = anak.tempat;
    selectedDate.value = anak.tanggalLahir.toDate();
    if (anak.fotoAnak.isNotEmpty) {
      fotoAnak.value = File(anak.fotoAnak);
    }
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> pickFotoAnak() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      fotoAnak.value = File(pickedImage.path);
    }
  }

  Future<String> uploadFotoAnak(File fotoAnak) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('foto_anak')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageRef.putFile(fotoAnak);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Terjadi kesalahan saat mengunggah foto anak: $e');
      rethrow;
    }
  }

  Future<void> updateAnakData(AnakModel anak) async {
    final namaLengkap = namaController.text.trim();
    final namaPanggilan = panggilanController.text.trim();
    final tempat = tempatController.text.trim();

    if (namaLengkap.isEmpty || namaPanggilan.isEmpty || tempat.isEmpty) {
      Get.snackbar('Error', 'Mohon isi semua data anak.',
          backgroundColor: red, colorText: white);
      return;
    }

    final updatedData = {
      'nama_lengkap': namaLengkap,
      'nama_panggilan': namaPanggilan,
      'tempat': tempat,
      'tanggal_lahir': Timestamp.fromDate(selectedDate.value),
    };

    if (fotoAnak.value != null && fotoAnak.value!.existsSync()) {
      final fotoAnakUrl = await uploadFotoAnak(fotoAnak.value!);
      updatedData['foto_anak'] = fotoAnakUrl;
    }

    try {
      await FirebaseFirestore.instance
          .collection('anak')
          .doc(anak.docId)
          .update(updatedData);
      debugPrint('Data anak berhasil diperbarui.');
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Data anak berhasil diperbarui.',
        backgroundColor: Colors.transparent,
        colorText: white,
      );
    } catch (e) {
      debugPrint('Terjadi kesalahan saat memperbarui data anak: $e');
      // Tampilkan pesan atau handling error lainnya
    }
  }
}
