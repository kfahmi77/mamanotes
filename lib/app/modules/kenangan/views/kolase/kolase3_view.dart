import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../data/common/style.dart';
import '../../controllers/kolase3_controller.dart';
import '../kolase_foto_view.dart';
import 'kolase2_view.dart';

class Kolase3View extends GetView<Kolase3Controller> {
  const Kolase3View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                'kembali',
                style: redTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controller.isSaving.value != true) {
                  controller.saveData();
                }
              },
              child: Obx(() {
                return Text(
                    controller.isSaving.value != true
                        ? 'Simpan'
                        : 'Menyimpan...',
                    style: redTextStyle.copyWith(
                      color: Colors.white,
                    ));
              }),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Screenshot(
                  controller: controller.screenshotController,
                  child: FrameKolase(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Obx(
                            () => controller.imagePaths[0] == ''
                                ? InkWell(
                                    onTap: () =>
                                        controller.getImageFromGallery(0),
                                    child: SizedBox(
                                      width: 230.w,
                                      child: Container(
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Icon(
                                            Icons.photo_camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 230.w,
                                    child: Image.file(
                                      File(controller.imagePaths[0]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Obx(
                                  () => controller.imagePaths[1] == ''
                                      ? InkWell(
                                          onTap: () =>
                                              controller.getImageFromGallery(1),
                                          child: SizedBox(
                                            width: 230.w,
                                            height: 120.h,
                                            child: Container(
                                              color: Colors.grey,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.photo_camera,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 230.w / 2,
                                          height: 120.h,
                                          child: Image.file(
                                            File(controller.imagePaths[1]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Obx(
                                  () => controller.imagePaths[2] == ''
                                      ? InkWell(
                                          onTap: () =>
                                              controller.getImageFromGallery(2),
                                          child: SizedBox(
                                            width: 230.w,
                                            height: 120.h,
                                            child: Container(
                                              color: Colors.grey,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.photo_camera,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 230.w / 2,
                                          height: 120.h,
                                          child: Image.file(
                                            File(controller.imagePaths[2]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: Obx(
                            () => controller.imagePaths[3] == ''
                                ? InkWell(
                                    onTap: () =>
                                        controller.getImageFromGallery(3),
                                    child: SizedBox(
                                      width: 230.w,
                                      child: Container(
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Icon(
                                            Icons.photo_camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 230.w,
                                    child: Image.file(
                                      File(controller.imagePaths[3]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      controller.selectDate(context);
                    },
                    child: SizedBox(
                      width: 90.w,
                      height: 40.h,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                            size: 24,
                          ),
                          Obx(
                            () => Text(
                              // ignore: unnecessary_null_comparison
                              controller.selectedDate.value == null
                                  ? 'Select Date'
                                  : DateFormat.yMd('id').format(
                                      controller.selectedDate.value,
                                    ),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextFieldCaptionKenangan(controller: controller.captionController),
          ],
        ),
      ),
    );
  }
}
