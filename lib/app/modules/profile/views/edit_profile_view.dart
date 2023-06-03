import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/common/style.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: Text(
          'Edit Profil',
          style: redTextStyle.copyWith(
              fontWeight: bold, fontSize: 16.0, color: white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: red,
                      child: SafeArea(
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.images,
                                color: white,
                              ),
                              title: Text(
                                'Ambil dari Galeri',
                                style: redTextStyle.copyWith(
                                    fontWeight: normal,
                                    fontSize: 15.0.sp,
                                    color: white),
                              ),
                              onTap: () {
                                controller.getImage(ImageSource.gallery);
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.camera,
                                color: white,
                              ),
                              title: Text('Ambil dari Kamera',
                                  style: redTextStyle.copyWith(
                                      fontWeight: normal,
                                      fontSize: 15.0.sp,
                                      color: white)),
                              onTap: () {
                                controller.getImage(ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Align(
                alignment: const AlignmentDirectional(0, -0.8),
                child: Obx(() {
                  return Container(
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
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
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
                                backgroundImage: controller.image.value != null
                                    ? FileImage(controller.image.value!)
                                    : NetworkImage(
                                        controller.currentUser?.photoURL ??
                                            'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                                      ) as ImageProvider<Object>,
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(FontAwesomeIcons.user),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.0.w),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () => controller.validateAndSaveChanges(context),
              child: Text('Simpan Perubahan', style: TextStyle(color: white)),
            ),
          ],
        ),
      ),
    );
  }
}
