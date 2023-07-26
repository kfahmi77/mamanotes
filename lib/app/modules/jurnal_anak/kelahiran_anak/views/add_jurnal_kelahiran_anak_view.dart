import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/repository/auth.dart';

import '../controllers/add_jurnal_kelahiran_anak.dart';

class AddKelahiranAnakView extends GetView<AddStimulusAnakController> {
  final String anakId;
  final String kelahiranAnakId;

  const AddKelahiranAnakView(
      {Key? key, required this.anakId, required this.kelahiranAnakId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authC = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: const Text('Kelahiran Anak'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    controller.selectTime(context);
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Waktu Lahir',
                      labelStyle: TextStyle(
                          color: red), // Change the label font color to red
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .red), // Change the bottom outline color to red
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .red), // Change the bottom outline color when focused to red
                      ),
                    ),
                    enabled: false,
                    controller: controller.timeController,
                    style: TextStyle(color: red),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Waktu lahir harus diisi.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tempat Lahir',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  style: TextStyle(color: red),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tempat lahir harus diisi.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.birthPlace = value!;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Dokter/Bidan',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  style: TextStyle(color: red),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Dokter/Bidan yang melayani harus diisi.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.medicalPersonnel = value!;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Berat Badan (kg)',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  style: TextStyle(color: red),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat badan harus diisi.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Berat badan harus berupa angka.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.weight = double.parse(value!);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tinggi Badan (cm)',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  style: TextStyle(color: red),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tinggi badan harus diisi.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Tinggi badan harus berupa angka.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.height = double.parse(value!);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Doa dari Bunda',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  style: TextStyle(color: red),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Doa dari Bunda harus diisi.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.motherPrayer = value!;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Doa dari Ayah',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  style: TextStyle(color: red),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Doa dari Ayah harus diisi.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.fatherPrayer = value!;
                  },
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        onTap: () {
                          controller.pickBirthPhoto();
                        },
                        child: Obx(
                          () => Container(
                            width: 320.w,
                            height: 150.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: Colors.red, width: 1.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: controller.birthPhotoPath.value != null
                                    ? FileImage(
                                        controller.birthPhotoPath.value!)
                                    : const AssetImage("assets/images/grey.png")
                                        as ImageProvider<Object>,
                              ),
                            ),
                            child: authC.image.value == null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 50.sp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Foto Anak",
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        onTap: () {
                          controller.pickFootPrintPhoto();
                        },
                        child: Obx(
                          () => Container(
                            width: 320.w,
                            height: 150.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: Colors.red, width: 1.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: controller.footPrintPhotoPath.value !=
                                        null
                                    ? FileImage(
                                        controller.footPrintPhotoPath.value!)
                                    : const AssetImage("assets/images/grey.png")
                                        as ImageProvider<Object>,
                              ),
                            ),
                            child: authC.image.value == null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 50.sp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Foto cap kaki anak",
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        onTap: () {
                          controller.pickDeliveryPhoto();
                        },
                        child: Obx(
                          () => Container(
                            width: 320.w,
                            height: 150.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: Colors.red, width: 1.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: controller.deliveryPhotoPath.value !=
                                        null
                                    ? FileImage(
                                        controller.deliveryPhotoPath.value!)
                                    : const AssetImage("assets/images/grey.png")
                                        as ImageProvider<Object>,
                              ),
                            ),
                            child: authC.image.value == null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 50.sp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " Foto Persalinan",
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
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(red),
                      ),
                      onPressed: () =>
                          controller.submitForm(anakId, kelahiranAnakId),
                      child: const Text('Simpan Data'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
