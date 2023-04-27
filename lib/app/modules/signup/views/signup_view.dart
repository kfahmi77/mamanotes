import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/common/style.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: "dewi");
    final TextEditingController emailController =
        TextEditingController(text: 'admin@gmail.com');
    final TextEditingController passwordController =
        TextEditingController(text: 'fahmi0810');
    ScreenUtil.init(context, designSize: const Size(376, 667));
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
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
                height: 450.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF597B),
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
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 50.0, 0.0, 0.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 50.0, 20.0, 0.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          focusNode: controller.focusNode,
                          controller: nameController,
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
                          controller: emailController,
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
                            controller: passwordController,
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
                            onPressed: () {},
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
