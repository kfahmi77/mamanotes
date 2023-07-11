import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/modules/profile_keluarga/controllers/edit_profile_keluarga_controller.dart';
import 'package:mamanotes/app/modules/profile_keluarga/models/profile_keluarga_model.dart';

import '../../../data/common/style.dart';
import '../../../data/common/widget/logo_widget.dart';

class EditProfileKeluargaView extends GetView<EditProfileKeluargaController> {
  const EditProfileKeluargaView({Key? key, required this.keluargaModel})
      : super(key: key);
  final Keluarga keluargaModel;
  @override
  Widget build(BuildContext context) {
    controller.init(keluargaModel);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: const LogoWidget(),
        actions: [
          IconButton(
            onPressed: () {
              controller.updateKeluargaData(keluargaModel);
            },
            icon: Icon(
              FontAwesomeIcons.floppyDisk,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: controller.namaKeluargaController,
                  decoration: const InputDecoration(labelText: 'Nama Keluarga'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Keluarga tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.mottoKeluargaController,
                  decoration:
                      const InputDecoration(labelText: 'Motto Keluarga'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Motto Keluarga tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.visiMisiController,
                  decoration: const InputDecoration(labelText: 'Visi dan Misi'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Visi dan Misi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.alamatRumahController,
                  decoration: const InputDecoration(labelText: 'Alamat Rumah'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat Rumah tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.namaAyahController,
                  decoration: const InputDecoration(labelText: 'Nama Ayah'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Ayah tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                Obx(() {
                  if (controller.fotoAyah.value != null &&
                      controller.fotoAyah.value!.existsSync()) {
                    return GestureDetector(
                      onTap: () => controller.pickFotoAyah(),
                      child: Image.file(
                        File(controller.fotoAyah.value!.path),
                        width: 350.w,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4.0.r),
                      child: CachedNetworkImage(
                        imageUrl: keluargaModel.ayah.foto,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: 350.w,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                }),
                TextFormField(
                  controller: controller.namaIbuController,
                  decoration: const InputDecoration(labelText: 'Nama Ibu'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Ibu tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                Obx(() {
                  if (controller.fotoIbu.value != null &&
                      controller.fotoIbu.value!.existsSync()) {
                    return GestureDetector(
                      onTap: () {
                        controller.pickFotoIbu();
                      },
                      child: Image.file(
                        File(controller.fotoIbu.value!.path),
                        width: 350.w,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        controller.pickFotoIbu();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0.r),
                        child: CachedNetworkImage(
                          imageUrl: keluargaModel.ibu.foto,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: 350.w,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
