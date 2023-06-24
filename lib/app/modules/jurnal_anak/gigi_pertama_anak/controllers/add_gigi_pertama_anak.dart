import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ImageUploadController extends GetxController {
  final CollectionReference imagesCollection =
      FirebaseFirestore.instance.collection('images');

  Future<void> uploadImage(File image) async {
    // Mengunggah gambar ke Firebase Storage
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(image);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      
      // Mendapatkan URL gambar yang diunggah
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      
      // Menyimpan URL gambar ke Firestore
      await saveImageUrl(imageUrl);
      
      Get.snackbar('Success', 'Image uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image');
    }
  }

  Future<void> saveImageUrl(String imageUrl) async {
    // Menyimpan URL gambar ke Firestore
    try {
      await imagesCollection.add({'imageUrl': imageUrl});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}