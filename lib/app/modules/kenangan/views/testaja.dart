import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/modules/kenangan/views/kolase2_view.dart';

import 'kolase1_view.dart';

class KolaseFotoView extends StatefulWidget {
  const KolaseFotoView({Key? key}) : super(key: key);

  @override
  createState() => _KolaseFotoViewState();
}

class _KolaseFotoViewState extends State<KolaseFotoView> {
  int selectedCollageType = 1;

  void navigateToNextScreen() {
    // Lakukan navigasi ke halaman berikutnya berdasarkan selectedCollageType
    switch (selectedCollageType) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Kolase1View()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Kolase2View()),
        );
        break;
      default:
        // Handle default case
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'kembali',
                  style: TextStyle(
                    fontWeight: normal,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigateToNextScreen();
                },
                child: Text(
                  'lanjut',
                  style: TextStyle(
                    fontWeight: normal,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          child: PreviewKolase(
            selectedCollageType: selectedCollageType,
            onCollageTypeSelected: (int collageType) {
              setState(() {
                selectedCollageType = collageType;
              });
            },
          ),
        ),
      ),
    );
  }
}

class PreviewKolase extends StatelessWidget {
  final int selectedCollageType;
  final ValueChanged<int> onCollageTypeSelected;

  const PreviewKolase({
    Key? key,
    required this.selectedCollageType,
    required this.onCollageTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget collageWidget;

    if (selectedCollageType == 1) {
      // Kolase tipe 1
      collageWidget = Container(
        width: 320.w,
        height: 480.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 10,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (selectedCollageType == 2) {
      // Kolase tipe 2
      collageWidget = Container(
        width: 320,
        height: 480,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 10,
          ),
        ),
        child: const Column(
            // ... kode kolase tipe 2
            ),
      );
    } else {
      // Kolase default jika tipe yang dipilih tidak ada
      collageWidget = Container();
    }

    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: collageWidget,
                ),
              ),
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          onCollageTypeSelected(1);
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: selectedCollageType == 1
                                ? background
                                : background.withOpacity(0.5),
                            border: Border.all(
                              color: selectedCollageType == 1
                                  ? white // Ubah warna border saat dipilih
                                  : Colors
                                      .transparent, // Hilangkan border saat tidak dipilih
                              width: 5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Item 1',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onCollageTypeSelected(2);
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: selectedCollageType == 2
                                ? background
                                : background.withOpacity(0.5),
                            border: Border.all(
                              color: selectedCollageType == 2
                                  ? white // Ubah warna border saat dipilih
                                  : Colors
                                      .transparent, // Hilangkan border saat tidak dipilih
                              width: 5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Item 2',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
