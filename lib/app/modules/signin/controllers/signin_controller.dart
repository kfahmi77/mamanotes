import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final inputText = RxString('');
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
}
