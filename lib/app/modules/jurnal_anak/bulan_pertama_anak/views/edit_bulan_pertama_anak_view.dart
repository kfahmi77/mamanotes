import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/common/style.dart';
import '../controllers/edit_bulan_pertama_anak_controller.dart';
import '../models/bulan_pertama_anak_model.dart';

class EditBulanPertamaAnakView extends GetView<EditBulanPertamaAnakController> {
  final BulanPertamaAnakModel bulanPertamaAnak;

  const EditBulanPertamaAnakView({Key? key, required this.bulanPertamaAnak})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBulanPertamaAnakController());
    controller.init(bulanPertamaAnak);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: const Text('Edit Gambar Duduk Anak'),
        actions: [
          IconButton(
            onPressed: () {
              controller.updateImage(bulanPertamaAnak.documentId,
                  bulanPertamaAnak.bulanPertamaAnakId);
            },
            icon: const Icon(
              FontAwesomeIcons.penToSquare,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Ambil dari Galeri'),
                            onTap: () {
                              controller.pickFotoBulanPertamaAnak(ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_camera),
                            title: const Text('Ambil dari Kamera'),
                            onTap: () {
                              controller.pickFotoBulanPertamaAnak(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.red, width: 1.0),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Obx(() {
                if (controller.fotoBulanPertamaAnak.value != null &&
                    controller.fotoBulanPertamaAnak.value!.existsSync()) {
                  return Image.file(
                    File(controller.fotoBulanPertamaAnak.value!.path),
                    width: 350.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  );
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4.0.r),
                    child: CachedNetworkImage(
                      imageUrl: bulanPertamaAnak.imageUrl,
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
            ),
          ),
        ),
      ),
    );
  }
}