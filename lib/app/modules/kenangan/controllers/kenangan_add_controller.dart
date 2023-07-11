import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';

class KenanganAddController extends GetxController {
  final picker = ImagePicker();
  var selectedDate = DateTime.now().obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  DateTime now = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null);
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  Rx<File?> image = Rx<File?>(null);
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<String> uploadImage(File file, String uid) async {
    Reference ref =
        _storage.ref().child("kenangan/${uid + now.toString()}.jpg");
    await ref.putFile(file);
    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadDefaultImage(String uid) async {
    String url = '';
    final ByteData bytes = await rootBundle.load('assets/images/daughter.png');
    final Uint8List data = bytes.buffer.asUint8List();

    final Reference ref =
        _storage.ref().child('kenangan/${uid + now.toString()}.jpg');
    final UploadTask task = ref.putData(data);

    await task.whenComplete(() async {
      url = await ref.getDownloadURL();
      image.value = null;
    });
    return url;
  }

  Future<Map<String, dynamic>> addKenangan(Map<String, dynamic> data) async {
    try {
      String imageUrl = await (image.value != null
          ? uploadImage(image.value!, auth.currentUser!.uid)
          : uploadDefaultImage(auth.currentUser!.uid));
      var hasil = await _firestore.collection("kenangan").add(data);
      await _firestore.collection("kenangan").doc(hasil.id).update({
        "kenanganId": hasil.id,
        "image_url": imageUrl,
        "uid": auth.currentUser!.uid
      });

      return {
        "error": false,
        "message": "Berhasil menambah kenangan.",
      };
    } catch (e) {
      // Error general
      debugPrint(e.toString());
      return {
        "error": true,
        "message": "Tidak dapat menambah kenangan.",
      };
    }
  }
}
