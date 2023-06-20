import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mamanotes/app/modules/kenangan/views/kolase_foto_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../../data/common/style.dart';
import '../../controllers/kolase1_controller.dart';

class Kolase2Controller extends GetxController {
  final RxList<String> imagePaths = List.generate(3, (_) => '').obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final ScreenshotController screenshotController = ScreenshotController();
  final firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? auth = FirebaseAuth.instance.currentUser;
  final TextEditingController captionController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  Future<void> getImageFromGallery(int index) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePaths[index] = pickedFile.path;
    }
  }

  Future<void> uploadScreenshot() async {
    Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      String fileName = '${DateTime.now()}.png';
      firebase_storage.Reference ref =
          firebaseStorage.ref().child('kenangan/$fileName');
      await ref.putData(imageBytes);

      String downloadURL = await ref.getDownloadURL();
      print('Screenshot URL: $downloadURL');

      // Simpan URL ke Firestore dengan nama koleksi anak
      var hasil = await firestore.collection("kenangan").add({
        "kenanganId": "",
        "image_url": downloadURL,
        "uid": auth!.uid,
        "caption": captionController.text,
      });
      await firestore.collection("kenangan").doc(hasil.id).update({
        "kenanganId": hasil.id,
      });

      // Kembali ke halaman sebelumnya
      Get.back();
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Kolase berhasil disimpan',
      );
    }
  }
}

class Kolase2View extends GetView<Kolase2Controller> {
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
              child: const Text(
                'kembali',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                controller.uploadScreenshot();
              },
              child: const Text(
                'Simpan',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
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

  final TextEditingController  controller;

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
