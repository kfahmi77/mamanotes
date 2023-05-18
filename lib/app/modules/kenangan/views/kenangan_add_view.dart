import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/common/widget/logo_widget.dart';
import 'package:mamanotes/app/modules/kenangan/controllers/kenangan_add_controller.dart';

class KenanganAddView extends GetView<KenanganAddController> {
  const KenanganAddView({super.key});

  @override
  Widget build(BuildContext context) {
    final KenanganAddController authC = Get.find<KenanganAddController>();
    TextEditingController captionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const LogoWidget(),
        backgroundColor: background,
        centerTitle: true,
        elevation: 0,
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
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
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                maxLength: 30,
                controller: captionController,
                decoration: const InputDecoration(
                  labelText: 'Caption',
                  labelStyle: TextStyle(
                    color: Colors.red,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  helperText: "Apa captionnya?",
                ),
                onChanged: (value) {},
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
                                  authC.getImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_camera),
                                title: const Text('Ambil dari Kamera'),
                                onTap: () {
                                  authC.getImage(ImageSource.camera);
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
                    width: 320.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.red, width: 1.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: authC.image.value != null
                            ? FileImage(authC.image.value!)
                            : const AssetImage("assets/images/grey.png")
                                as ImageProvider<Object>,
                      ),
                    ),
                    child: authC.image.value == null
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
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 320.w,
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
                              if (captionController.text.isNotEmpty) {
                                controller.isLoading(true);
                                Map<String, dynamic> hasil =
                                    await controller.addKenangan({
                                  "caption": captionController.text,
                                  "create_at": controller.selectedDate.value,
                                });
                                controller.isLoading(false);

                                Get.back();

                                Get.snackbar(
                                    hasil["error"] == true
                                        ? "Error"
                                        : "Success",
                                    hasil["message"]);
                              } else {
                                Get.snackbar(
                                    "Error", "Semua data wajib diisi.");
                              }
                            }
                          },
                          child: Text(
                            'Simpan',
                            style: redTextStyle.copyWith(
                                color: white, fontSize: 15.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
