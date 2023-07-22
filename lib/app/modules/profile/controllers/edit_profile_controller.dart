import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamanotes/app/modules/dashboard/views/dashboard_view.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  Rx<File?> image = Rx<File?>(null);
  final picker = ImagePicker();
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    // Set nilai awal pada controller nama
    nameController.text = currentUser?.displayName ?? '';
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<void> validateAndSaveChanges(BuildContext context) async {
    if (nameController.text.isEmpty && image.value == null) {
      Get.snackbar('Error', 'Data tidak boleh kosong');
    }
    if (nameController.text.isNotEmpty || image.value != null) {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      await updateProfile();

      Get.offAll(() => const DashboardView(), transition: Transition.rightToLeft);
      Get.snackbar('Sukses', 'data profil berhasil diubah');
    }
  }

  Future<void> updateProfile() async {
    try {
      if (nameController.text.isNotEmpty) {
        await currentUser?.updateDisplayName(nameController.text);
      }
      if (image.value != null) {
        String photoURL = await uploadImageToFirebaseStorage(image.value!);
        await currentUser?.updatePhotoURL(photoURL);
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to update profile.');
      print('Error updating profile: $error');
    }
  }

  Future<String> uploadImageToFirebaseStorage(File file) async {
    final ref =
        FirebaseStorage.instance.ref().child('profile/${currentUser?.uid}.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
