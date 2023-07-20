import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/repository/auth.dart';

import '../controllers/edit_kelahiran_anak.dart';
import '../models/kelahiran_anak_model.dart';

class EditKelahiranAnakView extends GetView<EditJurnalKelahiranAnakController> {
  const EditKelahiranAnakView({Key? key, required this.kelahiranAnak})
      : super(key: key);
  final KelahiranAnak kelahiranAnak;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditJurnalKelahiranAnakController());
    controller.init(kelahiranAnak);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: const Text('Kelahiran Anak'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              controller.updateKelahiranAnakData(
                  kelahiranAnak.anakId, kelahiranAnak.kelahiranAnakId);
            },
            icon: Icon(
              FontAwesomeIcons.solidFloppyDisk,
              color: white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {
                    controller.selectTime(
                        context, controller.waktuController.text);
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Waktu Lahir',
                      labelStyle: TextStyle(color: red),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: red),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: red),
                      ),
                      errorText: controller.waktuController.text.isEmpty
                          ? 'Waktu lahir harus diisi.'
                          : null,
                    ),
                    enabled: false,
                    controller: controller.waktuController,
                    style: TextStyle(color: red),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Waktu lahir harus diisi.';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.tempatController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Tempat Lahir',
                    labelStyle: TextStyle(color: red),
                    hintText: 'Misal Rumah Sakit / Puskesmas',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.dokterBidanController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Nama Dokter / Bidan',
                    labelStyle: TextStyle(color: red),
                    hintText: 'Masukkan Nama Dokter / Bidan',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.beratController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Berat Badan',
                    labelStyle: TextStyle(color: red),
                    hintText: 'Masukkan Berat Badan',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.tinggiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Tinggi Badan',
                    labelStyle: TextStyle(color: red),
                    hintText: 'Masukkan Tinggi Badan',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.doaAyahController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Doa dari Ayah',
                    labelStyle: TextStyle(color: red),
                    hintText: 'Masukkan Doa dari Ayah',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.doaIbuController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Doa dari Ibu',
                    labelStyle: TextStyle(color: red),
                    hintText: 'Masukkan Doa dari Ibu',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Foto Kelahiran Anak',
                  style: TextStyle(
                    color: red,
                    fontSize: 14.sp,
                    fontWeight: normal,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: controller.pickFotoAnak,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: red),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Obx(() {
                      if (controller.birthPhotoPath.value != null &&
                          controller.birthPhotoPath.value!.existsSync()) {
                        return Image.file(
                          File(controller.birthPhotoPath.value!.path),
                          width: 350.w,
                          height: 150.h,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(4.0.r),
                          child: CachedNetworkImage(
                            imageUrl: kelahiranAnak.birthPhotoUrl,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: 350.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Foto Kelahiran',
                  style: TextStyle(
                    color: red,
                    fontSize: 14.sp,
                    fontWeight: normal,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: controller.pickFotoKelahiran,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: red),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Obx(() {
                      if (controller.deliveryPhotoPath.value != null &&
                          controller.deliveryPhotoPath.value!.existsSync()) {
                        return Image.file(
                          File(controller.deliveryPhotoPath.value!.path),
                          width: 350.w,
                          height: 150.h,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(4.0.r),
                          child: CachedNetworkImage(
                            imageUrl: kelahiranAnak.deliveryPhotoUrl,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: 350.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Foto Kaki Anak',
                  style: TextStyle(
                    color: red,
                    fontSize: 14.sp,
                    fontWeight: normal,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: controller.pickFotoKaki,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: red),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Obx(() {
                      if (controller.footPrintPhotoPath.value != null &&
                          controller.footPrintPhotoPath.value!.existsSync()) {
                        return Image.file(
                          File(controller.footPrintPhotoPath.value!.path),
                          width: 350.w,
                          height: 150.h,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(4.0.r),
                          child: CachedNetworkImage(
                            imageUrl: kelahiranAnak.footPrintPhotoUrl,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: 350.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
