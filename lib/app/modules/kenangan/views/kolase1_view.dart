import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mamanotes/app/modules/kenangan/views/kenangan_view.dart';
import 'package:screenshot/screenshot.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Kolase1View extends StatefulWidget {
  const Kolase1View({Key? key}) : super(key: key);

  @override
  createState() => _Kolase1ViewState();
}

class _Kolase1ViewState extends State<Kolase1View> {
  ScreenshotController screenshotController = ScreenshotController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  DateTime selectedDate = DateTime.now();
  final _firestore = FirebaseFirestore.instance;
  TextEditingController captionController = TextEditingController();

  bool isSaveButtonEnabled = false;
  FirebaseStorage storage = FirebaseStorage.instance;
  List<dynamic> photos = List.generate(
      6, (_) => Colors.brown); // Menginisialisasi dengan warna coklat
  bool areAllPhotosSelected = false;

  Future<void> _pickPhoto(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        photos[index] = File(pickedFile.path);
        isSaveButtonEnabled = true;
      });

      // Periksa apakah semua foto sudah dipilih
      if (!photos.contains(Colors.brown)) {
        setState(() {
          areAllPhotosSelected = true;
          isSaveButtonEnabled = true; // Aktifkan tombol Simpan
        });
      }
    }
  }

  void _onPhotoTap(int index) async {
    await _pickPhoto(index);

    // Periksa apakah semua foto sudah dipilih
    if (areAllPhotosSelected) {
      // Mengambil screenshot
      final Uint8List? imageBytes = await screenshotController.capture();

      if (imageBytes != null) {
        _savePhoto(imageBytes);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Nilai awal tanggal adalah waktu saat ini
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _savePhoto(Uint8List imageBytes) async {
    // Menyimpan screenshot ke Firebase Storage
    final storageRef = storage.ref().child('screenshots/manual_screenshot.png');
    final uploadTask = storageRef.putData(imageBytes);

    // Menunggu hingga proses upload selesai
    await uploadTask.whenComplete(() async {
      // Mendapatkan URL foto yang diunggah
      final photoUrl = await storageRef.getDownloadURL();

      // Menyimpan URL foto ke Firestore
      var hasil = await _firestore.collection("kenangan").add({
        "image_url": photoUrl,
        "uid": auth.currentUser!.uid,
        "caption": captionController.text,
        "create_at": selectedDate,
      });
      await _firestore.collection("kenangan").doc(hasil.id).update({
        "kenanganId": hasil.id,
      });

      Get.off(KenanganView());
      Get.snackbar('Berhasil', 'Data kenangan  berhasil disimpan');
    }).catchError((error) {
      return error;
    });
  }

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
                Navigator.of(context).pop();
              },
              child: Text(
                'kembali',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (isSaveButtonEnabled) {
                  // Mengambil screenshot
                  final Uint8List? imageBytes =
                      await screenshotController.capture();

                  if (imageBytes != null) {
                    isSaveButtonEnabled = true;
                    _savePhoto(imageBytes);
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Peringatan'),
                        content: const Text(
                            'Harap pilih semua foto sebelum menyimpan.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                'Simpan',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 25.h, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.71,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Screenshot(
                                  controller: screenshotController,
                                  child: StaggeredGridView.countBuilder(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                      bottom: 10.h,
                                      left: 10.w,
                                      right: 10.w,
                                    ),
                                    crossAxisCount: 2,
                                    itemCount: 5,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Widget photoWidget;

                                      if (photos[index] is File) {
                                        // Jika foto adalah File (dari galeri)
                                        photoWidget = Image.file(
                                          photos[index],
                                          fit: BoxFit.cover,
                                        );
                                      } else {
                                        // Jika foto adalah warna coklat
                                        photoWidget = Container(
                                          color: photos[index],
                                        );
                                      }

                                      return GestureDetector(
                                        onTap: () {
                                          _onPhotoTap(index);
                                        },
                                        child: photoWidget,
                                      );
                                    },
                                    staggeredTileBuilder: (int index) {
                                      if (index == 0) {
                                        return const StaggeredTile.count(1, 1);
                                      } else if (index == 1) {
                                        return const StaggeredTile.count(1, 1);
                                      } else if (index == 2) {
                                        return const StaggeredTile.count(3, 1);
                                      } else {
                                        return const StaggeredTile.count(1, 1);
                                      }
                                    },
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                _selectDate(context);
                              },
                              child: SizedBox(
                                width: 80.w,
                                height: 40.h,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                      size: 24.sp,
                                    ),
                                    Text(
                                      selectedDate == null
                                          ? 'Select Date'
                                          : DateFormat.yMd('id').format(
                                              selectedDate), // Tampilkan tanggal terpilih di sini
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              controller: captionController,
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText:
                                    'Klik disini ya moms! \nuntuk menulis cerita dibalik foto ini >.<',
                                border: InputBorder
                                    .none, // Menghilangkan border bagian bawah
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
