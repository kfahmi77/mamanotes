import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/common/widget/logo_widget.dart';

import '../../home/models/anak_model.dart';
import '../controllers/edit_data_anak_controller.dart';

class EditDataAnakView extends GetView<EditDataAnakController> {
  final AnakModel anak;

  const EditDataAnakView({super.key, required this.anak});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditDataAnakController());
    controller.init(anak);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Anak',
          style: redTextStyle.copyWith(
              fontSize: 20.sp, fontWeight: bold, color: white),
        ),
        elevation: 0,
        backgroundColor: red,
        actions: [
          IconButton(
            onPressed: () async {
              await controller
                  .updateAnakData(anak); // Menunggu pembaruan data selesai
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
                child: TextFormField(
                  controller: controller.namaController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Nama Lengkap',
                    labelStyle: TextStyle(color: red),
                    hintText: 'Masukkan Nama Lengkap',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    errorText: controller.isFormValid.value
                        ? null
                        : 'Isian tidak boleh kosong',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.panggilanController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Nama Panggilan',
                    labelStyle: TextStyle(color: red),
                    hintText: 'Masukkan Nama Panggilan',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    errorText: controller.isFormValid.value
                        ? null
                        : 'Isian tidak boleh kosong',
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
                    hintText: 'Masukkan Tempat Lahir',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    errorText: controller.isFormValid.value
                        ? null
                        : 'Isian tidak boleh kosong',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: 320.w,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          controller.setSelectedDate(selectedDate);
                        }
                      });
                    },
                    child: Obx(
                      () => Text(
                        // ignore: unnecessary_null_comparison
                        controller.selectedDate.value == null
                            ? 'Pilih Tanggal'
                            : DateFormat.yMMMMEEEEd('id')
                                .format(controller.selectedDate.value),
                        style: redTextStyle.copyWith(
                            color: white, fontSize: 15.sp),
                      ),
                    ),
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
                      if (controller.fotoAnak.value != null &&
                          controller.fotoAnak.value!.existsSync()) {
                        return Image.file(
                          File(controller.fotoAnak.value!.path),
                          width: 350.w,
                          height: 150.h,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(4.0.r),
                          child: CachedNetworkImage(
                            imageUrl: anak.fotoAnak,
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
