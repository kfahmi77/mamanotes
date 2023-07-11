import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class AddStimulusAnakController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String birthPlace = '';
  String medicalPersonnel = '';
  double weight = 0.0;
  double height = 0.0;
  String motherPrayer = '';
  String fatherPrayer = '';
  final birthPhotoPath = Rx<File?>(null);
  final footPrintPhotoPath = Rx<File?>(null);
  final deliveryPhotoPath = Rx<File?>(null);
  final TextEditingController timeController = TextEditingController();
  late TimeOfDay selectedTime;
  final timeFormat = DateFormat('HH:mm');
  RxBool isBirthPhotoSelected = RxBool(false);
  RxBool isFootPrintPhotoSelected = RxBool(false);
  RxBool isDeliveryPhotoSelected = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    selectedTime = TimeOfDay.now();
    timeController.text = timeFormat.format(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
          selectedTime.hour, selectedTime.minute),
    );
  }

  void pickBirthPhoto() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      birthPhotoPath.value = File(pickedImage.path);
      isBirthPhotoSelected.value = true;
      update();
    } else {
      birthPhotoPath.value = null;
      isBirthPhotoSelected.value = false;
    }
  }

  void pickFootPrintPhoto() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      footPrintPhotoPath.value = File(pickedImage.path);
      isFootPrintPhotoSelected.value = true;
      update();
    } else {
      footPrintPhotoPath.value = null;
      isFootPrintPhotoSelected.value = false;
    }
  }

  void pickDeliveryPhoto() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      deliveryPhotoPath.value = File(pickedImage.path);
      isDeliveryPhotoSelected.value = true;
      update();
    } else {
      deliveryPhotoPath.value = null;
      isDeliveryPhotoSelected.value = false;
    }
  }

  void submitForm(String anakId,String kelahiranAnakId) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (!isBirthPhotoSelected.value ||
          !isFootPrintPhotoSelected.value ||
          !isDeliveryPhotoSelected.value) {
        Get.snackbar('Error', 'Pastikan semua gambar telah dipilih.');
        return;
      }

      try {
        // Upload foto anak lahir
        final birthPhotoRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('birth_photos/${path.basename(birthPhotoPath.value!.path)}');
        final birthUploadTask =
            birthPhotoRef.putFile(birthPhotoPath.value!);
        final birthPhotoUrl =
            await (await birthUploadTask).ref.getDownloadURL();

        // Upload foto cap kaki anak
        final footPrintPhotoRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('footprint_photos/${path.basename(footPrintPhotoPath.value!.path)}');
        final footPrintUploadTask =
            footPrintPhotoRef.putFile(footPrintPhotoPath.value!);
        final footPrintPhotoUrl =
            await (await footPrintUploadTask).ref.getDownloadURL();

        // Upload foto persalinan
        final deliveryPhotoRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('delivery_photos/${path.basename(deliveryPhotoPath.value!.path)}');
        final deliveryUploadTask =
            deliveryPhotoRef.putFile(deliveryPhotoPath.value!);
        final deliveryPhotoUrl =
            await (await deliveryUploadTask).ref.getDownloadURL();

        // Simpan data ke Firestore
        var docRef = FirebaseFirestore.instance
    .collection('anak')
    .doc(anakId)
    .collection('jurnal_anak')
    .doc(kelahiranAnakId);

await docRef.set({
  'birthTime': timeController.text,
  'birthPlace': birthPlace,
  'medicalPersonnel': medicalPersonnel,
  'weight': weight,
  'height': height,
  'motherPrayer': motherPrayer,
  'fatherPrayer': fatherPrayer,
  'birthPhotoUrl': birthPhotoUrl,
  'footPrintPhotoUrl': footPrintPhotoUrl,
  'deliveryPhotoUrl': deliveryPhotoUrl,
});


        Get.back();
        Get.back();
        Get.snackbar('Berhasil', 'Data kelahiran anak berhasil disimpan.');
      } catch (error) {
        debugPrint('Terjadi kesalahan: $error');
      }
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      selectedTime = pickedTime;
      timeController.text = timeFormat.format(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            selectedTime.hour, selectedTime.minute),
      );
      update();
    }
  }
}