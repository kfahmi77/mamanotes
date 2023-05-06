import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KenanganController extends GetxController {
  final isSearchVisible = false.obs;
  final searchController = TextEditingController();

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
