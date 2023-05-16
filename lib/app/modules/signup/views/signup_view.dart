import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/common/style.dart';
import '../../../data/repository/auth.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AuthController authC = Get.find<AuthController>();
    SignupController signupBinding = Get.find<SignupController>();
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 1.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFFFFF), Color(0xFFFFCDD7)],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(1.0, -1.0),
              end: AlignmentDirectional(-1.0, 1.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 500.h,
                decoration: BoxDecoration(
                  color: red,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Color(0x33000000),
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 50.0.h, 0.0, 0.0),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text('Ambil dari Galeri'),
                                        onTap: () {
                                          authC.getImage(ImageSource.gallery);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo_camera),
                                        title: const Text('Ambil dari Kamera'),
                                        onTap: () {
                                          authC.getImage(ImageSource.camera);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Obx(
                          () => Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: authC.image.value != null
                                    ? FileImage(authC.image.value!)
                                    : const AssetImage(
                                            "assets/images/daughter.png")
                                        as ImageProvider<Object>,
                              ),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black26,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 50.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 50.0, 20.0, 0.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Nama',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20, 20.0, 0.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: signupBinding.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 20.0, 0.0),
                      child: SizedBox(
                        height: 50,
                        child: Obx(
                          () => TextField(
                            obscureText: controller.isHidden.value,
                            controller: signupBinding.passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => controller.isHidden.toggle(),
                                icon: Icon(controller.isHidden.isFalse
                                    ? Icons.remove_red_eye_rounded
                                    : Icons.remove_red_eye_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.h)),
                    Align(
                      alignment: const AlignmentDirectional(0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: SizedBox(
                          width: 290.w,
                          height: 40.h,
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              backgroundColor: white,
                            ),
                            onPressed: () async {
                              if (controller.isLoading.isFalse) {
                                if (controller
                                        .emailController.text.isNotEmpty &&
                                    controller
                                        .passwordController.text.isNotEmpty) {
                                  controller.isLoading(true);
                                  Map<String, dynamic> hasil =
                                      await authC.register(
                                          controller.emailController.text,
                                          controller.passwordController.text,
                                          controller.nameController.text);
                                  controller.isLoading(false);

                                  if (hasil["error"] == true) {
                                    Get.snackbar("Error", hasil["message"]);
                                  } else {
                                    Get.snackbar("Berhasil",
                                        "Berhasil registrasi,silahkan cek email untuk verifikasi");
                                    Get.offAllNamed(Routes.signin);
                                  }
                                } else {
                                  Get.snackbar("Error",
                                      "Email,Password,Nama wajib diisi.");
                                }
                              }
                            },
                            child: Text("Daftar",
                                style: redTextStyle.copyWith(
                                    fontWeight: bold, color: red)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 20.0, 0.0, 0.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text('sudah punya akun?',
                            style: redTextStyle.copyWith(
                                fontWeight: bold, color: white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
