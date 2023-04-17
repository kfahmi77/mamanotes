import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final FocusNode focusNode = FocusNode();
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  onClose() {
    focusNode.dispose();
    super.onClose();
  }
}
