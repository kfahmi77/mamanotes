import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: const Text('Reset Password'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: controller.emailC,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: white),
            decoration: InputDecoration(
              filled: true,
              fillColor: red,
              hintText: 'Email',
              hintStyle: TextStyle(color: white),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => SizedBox(
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: controller.isLoading.isTrue
                    ? null
                    : () => controller.resetPassword(),
                child: Text(
                  controller.isLoading.isFalse ? 'Reset Sandi' : 'Loading...',
                  style: redTextStyle.copyWith(
                      fontSize: 14.sp, fontWeight: semiBold, color: white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
