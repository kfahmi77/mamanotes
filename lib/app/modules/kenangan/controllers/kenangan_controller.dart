import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/kenangan_model.dart';

class KenanganController extends GetxController {
  final isSearchVisible = false.obs;
  final searchController = TextEditingController();
  late RxList<KenanganModel> dataList = <KenanganModel>[].obs;
  final CollectionReference koleksiKenangan =
      FirebaseFirestore.instance.collection('kenangan');
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy, HH:mm', 'id');

  String ubahFormatTanggal(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return _dateFormat.format(dateTime);
  }

  void toggleSearch() {
    isSearchVisible.value = !isSearchVisible.value;
    if (!isSearchVisible.value) {
      clearSearch();
    }
  }

  void search(String value) {
    // Perform search here
  }

  void clearSearch() {
    searchController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      koleksiKenangan
          .orderBy('create_at', descending: false)
          .snapshots()
          .listen((querySnapshot) {
        dataList.assignAll(querySnapshot.docs
            .map((doc) => KenanganModel.fromJson(doc))
            .toList());
      });
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data $e}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
