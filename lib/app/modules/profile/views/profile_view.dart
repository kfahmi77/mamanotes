import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/repository/auth.dart';
import 'package:mamanotes/app/modules/signin/controllers/signin_controller.dart';
import 'package:mamanotes/app/modules/tentang/bindings/tentang_binding.dart';
import 'package:mamanotes/app/modules/tentang/views/tentang_view.dart';

import '../../../data/common/style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  AuthController authController = Get.find<AuthController>();
  ProfileController profileController = Get.put(ProfileController());
  getDocIndex() {
    final ref = FirebaseFirestore.instance.collection('users').doc();

// upload the data and include docID in it
    ref.set({
      'docID': ref.id,
      // rest of the data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo_mamanote.png',
          width: 150.w,
        ),
        backgroundColor: background,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: profileController.getDataUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Stack(
                children: snapshot.data!.docs.map((document) {
                  return Stack(
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
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.green,
                                      Colors.yellow,
                                      Colors.red,
                                      Colors.purple
                                    ]),
                                    shape: BoxShape.circle),
                                child: Padding(
                                  //this padding will be you border size
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      foregroundImage: AssetImage(
                                          'assets/images/daughter.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -0.40),
                            child: Text(
                              document['name'],
                              style: redTextStyle.copyWith(
                                fontWeight: semiBold,
                                color: black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -0.30),
                            child: Text(
                              document['email'],
                              style: redTextStyle.copyWith(
                                fontWeight: normal,
                                color: black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -0.15),
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                backgroundColor: background,
                              ),
                              onPressed: () {},
                              child: Text("Edit ",
                                  style:
                                      redTextStyle.copyWith(fontWeight: bold)),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, -0.01),
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
                              Map<String, dynamic> hasil =
                                  await authController.logout();
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
                  );
                }).toList(),
              );
            }
          }),
    );
  }
}
