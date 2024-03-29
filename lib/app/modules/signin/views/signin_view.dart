import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/modules/signup/bindings/signup_binding.dart';
import 'package:mamanotes/app/modules/signup/views/signup_view.dart';
import '../../../data/common/style.dart';
import '../../../data/repository/auth.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AuthController authC = Get.find<AuthController>();
    ScreenUtil.init(context, designSize: const Size(376, 667));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF1F4F8),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 400.w,
              height: 800.h,
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
                    width: 340.w,
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
                            width: 150.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 50.0, 20.0, 0.0),
                          child: SizedBox(
                            height: 50.h,
                            child: TextField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.text,
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
                            height: 50.h,
                            child: Obx(
                              () => TextField(
                                obscureText: controller.isHidden.value,
                                controller: controller.passwordController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        controller.isHidden.toggle(),
                                    icon: Icon(controller.isHidden.isFalse
                                        ? Icons.remove_red_eye_rounded
                                        : Icons.remove_red_eye_outlined),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 20.0, 20.0),
                              child: SizedBox(
                                height: 40.h,
                                width: 125.w,
                                child: TextButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    backgroundColor: white,
                                  ),
                                  onPressed: () {
                                    Get.to(const SignupView(),
                                        binding: SignupBinding());
                                  },
                                  child: Text("Daftar Baru",
                                      style: redTextStyle.copyWith(
                                          fontWeight: bold)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 20.0, 20.0),
                              child: SizedBox(
                                height: 40.h,
                                width: 125.w,
                                child: TextButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    backgroundColor: background,
                                  ),
                                  onPressed: () async {
                                    if (controller.isLoading.isFalse) {
                                      if (controller.emailController.text
                                              .isNotEmpty &&
                                          controller.passwordController.text
                                              .isNotEmpty) {
                                        controller.isLoading(true);
                                        Map<String, dynamic> hasil =
                                            await authC.login(
                                                controller.emailController.text,
                                                controller
                                                    .passwordController.text);
                                        controller.isLoading(false);

                                        if (hasil["error"] == true) {
                                          Get.snackbar(
                                              "Error", hasil["message"]);
                                        }
                                      } else {
                                        Get.snackbar("Error",
                                            "Email dan password wajib diisi.");
                                      }
                                    }
                                  },
                                  child: Text("Masuk",
                                      style: redTextStyle.copyWith(
                                          fontWeight: bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            child: SizedBox(
                              width: 290.w,
                              height: 40.h,
                              child: TextButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  backgroundColor: white,
                                ),
                                onPressed: () => authC.signInWithGoogle(),
                                icon: Image.asset(
                                  "assets/images/google.png",
                                  height: 20.h,
                                ),
                                label: Text("Masuk dengan akun Google",
                                    style: redTextStyle.copyWith(
                                        fontWeight: bold, color: black)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.resetPassword),
                            child: Text('lupa sandi?',
                                style: redTextStyle.copyWith(
                                    fontWeight: bold, color: white)),
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0)),
                        Obx(() => authC.isLoading.value
                            ? LoadingOverlay()
                            : SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitSpinningCircle(
      color: Colors.white,
      size: 50.0,
    ));
  }
}
