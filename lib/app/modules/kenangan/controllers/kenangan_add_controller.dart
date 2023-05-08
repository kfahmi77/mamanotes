import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';

class KenanganAddController extends GetxController {
  final picker = ImagePicker();
  var selectedDate = DateTime.now().obs;

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
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }
}
