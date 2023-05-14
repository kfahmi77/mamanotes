import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/kenangan_model.dart';

class KenanganController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  final isSearchVisible = false.obs;
  final searchController = TextEditingController();
  late RxList<KenanganModel> dataList = <KenanganModel>[].obs;
  final CollectionReference koleksiKenangan =
      FirebaseFirestore.instance.collection('kenangan');
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy, HH:mm', 'id');
  var isLoading = false.obs;

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
    if (value.isNotEmpty) {
      filterData(value);
    } else {
      dataList.assignAll(_allData);
    }
  }

  void clearSearch() {
    searchController.clear();
    dataList.assignAll(_allData);
  }

  late List<KenanganModel> _allData = [];

  @override
  void onInit() {
    print(user!.uid);
    super.onInit();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      koleksiKenangan
          .where('uid', isEqualTo: user!.uid)
          .snapshots()
          .listen((querySnapshot) {
        _allData = querySnapshot.docs
            .map((doc) => KenanganModel.fromJson(doc))
            .toList();
        dataList.assignAll(_allData);
        isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data $e}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void filterData(String keyword) {
    final List<KenanganModel> result = _allData
        .where((kenangan) =>
            kenangan.caption.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    dataList.assignAll(result);
  }
}
