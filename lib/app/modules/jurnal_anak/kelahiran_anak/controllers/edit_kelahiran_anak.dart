import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mamanotes/app/modules/jurnal_anak/kelahiran_anak/models/kelahiran_anak_model.dart';

class EditJurnalKelahiranAnakController extends GetxController {
  TextEditingController tempatController = TextEditingController();
  TextEditingController dokterBidanController = TextEditingController();
  TextEditingController beratController = TextEditingController();
  TextEditingController tinggiController = TextEditingController();
  TextEditingController doaIbuController = TextEditingController();
  TextEditingController doaAyahController = TextEditingController();
  TextEditingController waktuController = TextEditingController();

  final birthPhotoPath = Rx<File?>(null);
  final footPrintPhotoPath = Rx<File?>(null);
  final deliveryPhotoPath = Rx<File?>(null);

  late TimeOfDay selectedTime;
  final timeFormat = DateFormat('HH:mm');

  final picker = ImagePicker();

  void init(KelahiranAnak kelahiranAnak) {
    tempatController.text = kelahiranAnak.tempatLahir;
    dokterBidanController.text = kelahiranAnak.petugasKesehatan;
    beratController.text = kelahiranAnak.beratAnakLahir.toString();
    tinggiController.text = kelahiranAnak.tinggiAnakLahir.toString();
    doaIbuController.text = kelahiranAnak.doaIbu;
    doaAyahController.text = kelahiranAnak.doaAyah;
    waktuController.text = kelahiranAnak.waktuLahir;

    final List<String> parts = kelahiranAnak.waktuLahir.split(':');
    final int initialHour = int.parse(parts[0]);
    final int initialMinute = int.parse(parts[1]);
    selectedTime = TimeOfDay(hour: initialHour, minute: initialMinute);
    waktuController.text = timeFormat.format(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
          selectedTime.hour, selectedTime.minute),
    );

    if (kelahiranAnak.urlFotoAnak.isNotEmpty) {
      birthPhotoPath.value = File(kelahiranAnak.urlFotoAnak);
    }
    if (kelahiranAnak.urlFotoCapKaki.isNotEmpty) {
      footPrintPhotoPath.value = File(kelahiranAnak.urlFotoCapKaki);
    }
    if (kelahiranAnak.urlFotoKelahiran.isNotEmpty) {
      deliveryPhotoPath.value = File(kelahiranAnak.urlFotoKelahiran);
    }
  }

  Future<void> pickFoto(ImageSource source, Rx<File?> foto) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      foto.value = File(pickedImage.path);
    }
  }

  Future<void> pickFotoKaki() async {
    await pickFoto(ImageSource.gallery, footPrintPhotoPath);
  }

  Future<void> pickFotoKelahiran() async {
    await pickFoto(ImageSource.gallery, deliveryPhotoPath);
  }

  Future<void> pickFotoAnak() async {
    await pickFoto(ImageSource.gallery, birthPhotoPath);
  }

  Future<void> selectTime(BuildContext context, String initialTime) async {
    final List<int> parts = initialTime.split(':').map(int.parse).toList();
    final TimeOfDay initialSelectedTime =
        TimeOfDay(hour: parts[0], minute: parts[1]);

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialSelectedTime,
    );

    if (pickedTime != null) {
      selectedTime = pickedTime;
      waktuController.text = timeFormat.format(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            selectedTime.hour, selectedTime.minute),
      );

      update();
    }
  }

  Future<String> uploadFotoAnak(File fotoAnak) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('jurnal_anak/kelahiran_anak')
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

  Future<void> updateKelahiranAnakData(
      String anakId, String kelahiranAnakId) async {
    if (tempatController.text.isEmpty ||
        dokterBidanController.text.isEmpty ||
        beratController.text.isEmpty ||
        tinggiController.text.isEmpty ||
        doaIbuController.text.isEmpty ||
        doaAyahController.text.isEmpty ||
        waktuController.text.isEmpty ||
        birthPhotoPath.value == null ||
        footPrintPhotoPath.value == null ||
        deliveryPhotoPath.value == null) {
      Get.snackbar(
        'Perhatian',
        'Mohon lengkapi semua data.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final updatedData = {
      'tempatLahir': tempatController.text,
      'waktuLahir': waktuController.text,
      'doaAyah': doaAyahController.text,
      'tinggiAnakLahir': double.parse(tinggiController.text),
      'petugasKesehatan': dokterBidanController.text,
      'doaIbu': doaIbuController.text,
      'beratAnakLahir': double.parse(beratController.text),
    };

    if (birthPhotoPath.value != null && birthPhotoPath.value!.existsSync()) {
      final fotoAnakUrl = await uploadFotoAnak(birthPhotoPath.value!);
      updatedData['urlFotoAnak'] = fotoAnakUrl;
    }
    if (deliveryPhotoPath.value != null &&
        deliveryPhotoPath.value!.existsSync()) {
      final fotoKelahiranUrl = await uploadFotoAnak(deliveryPhotoPath.value!);
      updatedData['urlFotoKelahiran'] = fotoKelahiranUrl;
    }
    if (footPrintPhotoPath.value != null &&
        footPrintPhotoPath.value!.existsSync()) {
      final fotoJejakKakiUrl = await uploadFotoAnak(footPrintPhotoPath.value!);
      updatedData['tinggiAnakLahir'] = fotoJejakKakiUrl;
    }

    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      await FirebaseFirestore.instance
          .collection('anak')
          .doc(anakId)
          .collection('jurnal_anak')
          .doc(kelahiranAnakId)
          .update(updatedData);
      debugPrint('Data anak berhasil diperbarui.');
      update();
      Get.back();
      Get.back();
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Data anak berhasil diperbarui.',
        backgroundColor: Colors.transparent,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Terjadi kesalahan saat memperbarui data anak: $e');
      // Tampilkan pesan atau handling error lainnya
    }
  }
}
