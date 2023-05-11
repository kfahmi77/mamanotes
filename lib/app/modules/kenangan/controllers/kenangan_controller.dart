import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import '../models/kenangan_model.dart';

class KenanganController extends GetxController {
  final isSearchVisible = false.obs;
  final searchController = TextEditingController();
  final CollectionReference koleksiKenangan =
      FirebaseFirestore.instance.collection('kenangan');
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy, HH:mm', 'id');

  final RxList<KenanganModel> _daftarKenangan = RxList<KenanganModel>([]);

  List<KenanganModel> get daftarKenangan => _daftarKenangan;

  @override
  void onInit() {
    super.onInit();
    _ambilDataKenangan();
  }

  Future<void> _ambilDataKenangan() async {
    try {
      final QuerySnapshot snapshot = await koleksiKenangan.get();
      final List<KenanganModel> daftarKenangan = snapshot.docs
          .map((DocumentSnapshot dokumen) =>
              KenanganModel.fromJson(dokumen.data() as Map<String, dynamic>))
          .toList();
      _daftarKenangan.value = daftarKenangan;
    } catch (e) {
      debugPrint('Terjadi kesalahan: $e');
    }
  }

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
}
