import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/common/style.dart';
import '../controllers/add_berdiri_anak_controller.dart';

class AddBerdiriAnakView extends GetView<AddBerdiriAnakController> {
  final String documentId;
  final String berdiriAnakId;
  const AddBerdiriAnakView(
      {Key? key, required this.documentId, required this.berdiriAnakId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title:
            Text('Upload Gambar', style: redTextStyle.copyWith(color: white)),
        actions: [
          IconButton(
            onPressed: () {
              controller.uploadImage(documentId, berdiriAnakId);
            },
            icon: Icon(
              FontAwesomeIcons.solidFloppyDisk,
              color: red,
            ),
          ),
        ],
      ),
      body: Container(
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
                            controller.pickFotoBerdiriAnak(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera),
                          title: const Text('Ambil dari Kamera'),
                          onTap: () {
                            controller.pickFotoBerdiriAnak(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Obx(
            () => Container(
              padding: EdgeInsets.all(12.h),
              width: 350.w,
              height: 150.h,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.red, width: 1.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: controller.fotoBerdiriAnak.value != null
                      ? FileImage(controller.fotoBerdiriAnak.value!)
                      : const AssetImage("assets/images/grey.png")
                          as ImageProvider<Object>,
                ),
              ),
              child: controller.fotoBerdiriAnak.value == null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 50.sp,
                          color: Colors.white,
                        ),
                        Text(
                          "Ambil Foto Berdiri  Anak",
                          style: redTextStyle.copyWith(
                            color: white,
                            fontSize: 13.0.sp,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }
}
