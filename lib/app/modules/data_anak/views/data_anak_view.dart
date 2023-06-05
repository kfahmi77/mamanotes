import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mamanotes/app/data/common/style.dart';

import '../controllers/tambah_data_anak_controller.dart';

class TambahDataAnakView extends GetView<TambahDataAnakController> {
  const TambahDataAnakView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    final TextEditingController artiNamaController = TextEditingController();
    final TextEditingController golonganDarahController =
        TextEditingController();
    final TextEditingController namaLengkapController = TextEditingController();
    final TextEditingController namaPanggilanController =
        TextEditingController();
    final TextEditingController tanggalLahirController =
        TextEditingController();
    final TextEditingController tempatController = TextEditingController();
    DateTime? selectedDate;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: red,
          title: Text(
            'Tambah Data Anak',
            style: redTextStyle.copyWith(fontWeight: bold, color: white),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Nama Lengkap',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                  controller: namaLengkapController,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Nama Panggilan',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                  controller: namaPanggilanController,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Arti Nama',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                  controller: artiNamaController,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: FormField(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Jenis Kelamin',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: red,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: red,
                          ),
                        ),
                        labelStyle: TextStyle(color: red),
                        errorText: state.errorText,
                      ),
                      isEmpty: selectedValue == null,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedValue,
                          isDense: true,
                          onChanged: (value) {
                            // Mengubah nilai terpilih saat dropdown berubah
                            selectedValue = value;
                            state.didChange(value);
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'laki-laki',
                              child: Text('Laki-laki',
                                  style: redTextStyle.copyWith(
                                    fontWeight: normal,
                                    fontSize: 14.0.h,
                                  )),
                            ),
                            DropdownMenuItem(
                              value: 'perempuan',
                              child: Text(
                                'Perempuan',
                                style: redTextStyle.copyWith(
                                  fontWeight: normal,
                                  fontSize: 14.0.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        selectedDate = pickedDate;
                        tanggalLahirController.text =
                            DateFormat.yMMMMEEEEd('id').format(pickedDate);
                      }
                    });
                  },
                  controller: tanggalLahirController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Tanggal Lahir',
                    labelStyle: TextStyle(color: red),
                  ),
                  readOnly: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Tempat lahir',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                  controller: tempatController,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                    labelText: 'Golongan Darah',
                    labelStyle: TextStyle(color: red),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: red,
                      ),
                    ),
                  ),
                  controller: golonganDarahController,
                ),
              ),
              Container(
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
                                    controller.getImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_camera),
                                  title: const Text('Ambil dari Kamera'),
                                  onTap: () {
                                    controller.getImage(ImageSource.camera);
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: Colors.red, width: 1.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: controller.image.value != null
                              ? FileImage(controller.image.value!)
                              : const AssetImage("assets/images/grey.png")
                                  as ImageProvider<Object>,
                        ),
                      ),
                      child: controller.image.value == null
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
                                  "Ambil Foto",
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
              SizedBox(
                width: 155.h,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      if (namaLengkapController.text.isNotEmpty &&
                          namaPanggilanController.text.isNotEmpty &&
                          artiNamaController.text.isNotEmpty &&
                          selectedValue != null &&
                          selectedDate != null &&
                          tempatController.text.isNotEmpty &&
                          golonganDarahController.text.isNotEmpty &&
                          controller.image.value != null) {
                        controller.isLoading(true);
                        Map<String, dynamic> hasil =
                            await controller.addKenangan({
                          'arti_nama': artiNamaController.text,
                          'golongan_darah': golonganDarahController.text,
                          'jenis_kelamin': selectedValue,
                          'nama_lengkap': namaLengkapController.text,
                          'nama_panggilan': namaPanggilanController.text,
                          'tempat': tempatController.text,
                          "tanggal_lahir": controller.selectedDate.value,
                        });
                        controller.isLoading(false);

                        Get.back();

                        Get.snackbar(
                            hasil["error"] == true ? "Error" : "Success",
                            hasil["message"]);
                      } else {
                        Get.snackbar("Error", "Semua data wajib diisi.");
                      }
                    }
                  },
                  child: const Text('Simpan',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.h),
              ),
            ],
          ),
        ));
  }
}
