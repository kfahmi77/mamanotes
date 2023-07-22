import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mamanotes/app/modules/kenangan/views/kolase_foto_view.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../data/common/style.dart';
import '../../controllers/kolase2_controller.dart';

class Kolase2View extends GetView<Kolase2Controller> {
  const Kolase2View({super.key});

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
                      const SizedBox(height: 10),
                      Expanded(
                        child: Obx(
                          () => controller.imagePaths[1] == ''
                              ? InkWell(
                                  onTap: () =>
                                      controller.getImageFromGallery(1),
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
                                    File(controller.imagePaths[1]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Obx(
                          () => controller.imagePaths[2] == ''
                              ? InkWell(
                                  onTap: () =>
                                      controller.getImageFromGallery(2),
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
                                    File(controller.imagePaths[2]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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

class TextFieldCaptionKenangan extends StatelessWidget {
  const TextFieldCaptionKenangan({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100.h,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              hintText:
                  'Klik disini ya moms! \nuntuk menulis cerita dibalik foto ini >.<',
              border: InputBorder.none, // Menghilangkan border bagian bawah
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            ),
          ),
        )
      ],
    );
  }
}
