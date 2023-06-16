import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class Kolase1Controller extends GetxController {
  final ScreenshotController screenshotController = ScreenshotController();
  final RxBool isSaveButtonEnabled = false.obs;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final List<File?> photos =
      List.generate(6, (_) => null); // Initialize with null

  bool get areAllPhotosSelected => !photos.contains(null);

  Future<void> pickPhoto(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      photos[index] = file;
      isSaveButtonEnabled.value = true;

      // Check if all photos are selected
      if (!photos.contains(null)) {
        isSaveButtonEnabled.value = true; // Activate Save button
      }
    }
  }

  Future<void> onPhotoTap(int index) async {
    await pickPhoto(index);

    // Check if all photos are selected
    if (areAllPhotosSelected) {
      // Capture screenshot
      final Uint8List? imageBytes = await screenshotController.capture();

      if (imageBytes != null) {
        savePhoto(imageBytes);
      }
    }
  }

  Future<void> savePhoto(Uint8List imageBytes) async {
    // Save screenshot to Firebase Storage
    final storageRef = storage.ref().child('screenshots/manual_screenshot.png');
    final uploadTask = storageRef.putData(imageBytes);

    try {
      await uploadTask;
      // Get the uploaded photo URL
      final photoUrl = await storageRef.getDownloadURL();

      // Save photo URL to Firestore
      await FirebaseFirestore.instance
          .collection('koleksi_anak')
          .add({'photoUrl': photoUrl});

      print(
          'Screenshot berhasil diunggah ke Firebase Storage dan URL foto disimpan di Firestore');
    } catch (error) {
      print('Error uploading screenshot: $error');
    }
  }
}
