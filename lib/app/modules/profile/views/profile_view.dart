import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/widget/logo_widget.dart';
import 'package:mamanotes/app/data/repository/auth.dart';
import 'package:mamanotes/app/modules/tentang/views/tentang_view.dart';

import '../../../data/common/style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

// ignore: must_be_immutable
class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  AuthController authController = Get.find<AuthController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const LogoWidget(),
        backgroundColor: background,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: 400.w,
            height: 100.h,
            decoration: BoxDecoration(color: background),
          ),
          Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0, -0.8),
                child: Container(
                  width: 120.w,
                  height: 120.h,
                  clipBehavior: Clip.none,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Padding(
                        //this padding will be you border size
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          height: 115.h,
                          width: 115.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: CachedNetworkImageProvider(
                                    _auth.currentUser!.photoURL!),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: -25,
                                  child: RawMaterialButton(
                                    onPressed: () {},
                                    padding: const EdgeInsets.all(2.0),
                                    shape: const CircleBorder(),
                                    child: Image.asset(
                                      "assets/images/camera.png",
                                      width: 40.0.h,
                                      height: 40.0.h,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.30.h),
                child: Text(
                  _auth.currentUser!.displayName.toString(),
                  style: redTextStyle.copyWith(
                    fontWeight: semiBold,
                    color: black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.20.h),
                child: Text(
                  _auth.currentUser!.email.toString(),
                  style: redTextStyle.copyWith(
                    fontWeight: normal,
                    color: black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.05.h),
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(100.w, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    backgroundColor: background,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.editProfile);
                  },
                  child: Text("Edit ",
                      style: redTextStyle.copyWith(fontWeight: bold)),
                ),
              ),
            ],
          ),
          Align(
            alignment: const AlignmentDirectional(0, 0.1),
            child: Divider(
                height: 20,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: red),
          ),
          Align(
            alignment: const AlignmentDirectional(-0.8, 0.3),
            child: SizedBox(
              height: 100.0.h,
              width: 200.h,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const TentangView());
                },
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.userGroup,
                      color: background,
                    ),
                    Padding(padding: EdgeInsets.only(left: 10.r)),
                    SizedBox(
                      width: 100.0,
                      child: Text("Tentang kami",
                          style: redTextStyle.copyWith(
                              fontWeight: normal, color: black)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-0.8, 0.5),
            child: SizedBox(
              height: 100.0.h,
              width: 200.h,
              child: GestureDetector(
                onTap: () async {
                  Map<String, dynamic> hasil = await authController.logout();
                  if (hasil['error'] == false) {
                    Get.offAllNamed(Routes.signin);
                  } else {
                    Get.snackbar('Error', hasil['message']);
                  }
                },
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                      color: background,
                    ),
                    Padding(padding: EdgeInsets.only(left: 15.r)),
                    SizedBox(
                      width: 100.0,
                      child: Text("Keluar",
                          style: redTextStyle.copyWith(
                              fontWeight: normal, color: black)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
