import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/modules/jurnal_anak/controllers/jurnal_anak_controller.dart';

import '../../../data/common/widget/card_list_widget.dart';
import '../../my_diary/bindings/my_diary_binding.dart';
import '../../my_diary/views/my_diary_view.dart';

class DetailAnakView extends GetView {
  const DetailAnakView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    JurnalAnakController controller = Get.find<JurnalAnakController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Text(
            'Detail Anak',
            style: redTextStyle.copyWith(color: white, fontWeight: bold),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: red,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 6.h),
            child: Image.asset(
              "assets/images/switch_anak.png",
              width: 30.0,
              height: 30.0,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.h),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(
                'Pilih Anak',
                style: redTextStyle.copyWith(color: white, fontWeight: normal),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 26.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.h),
            child: SizedBox(
              width: 320.w,
              height: 200.h,
              child: Stack(
                children: [
                  Image.network(
                    "https://images.unsplash.com/flagged/photo-1559502867-c406bd78ff24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned.fill(
                    bottom: 0,
                    child: FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 0.3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.h),
                            bottomRight: Radius.circular(10.h),
                          ),
                          color: red.withOpacity(0.7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Nama : Khoirul Anam',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Lahir: 01 Januari 2021',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: red,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          // Implementasi logika aksi edit di sini
                          print('object');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Jurnal Perjalananku",
                style: redTextStyle.copyWith(
                  color: red,
                  fontWeight: bold,
                  fontSize: 18.h,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Divider(
            color: red,
            height: 5.h,
            thickness: 3.h,
            indent: 100.h,
            endIndent: 100.h,
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Moms, bantu aku isi jurnal ya >.<",
            style: redTextStyle.copyWith(
                fontWeight: normal, fontSize: 13.0, color: black),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(grey),
                  ),
                  onPressed: () {
                    // Logika aksi tombol
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Preview Jurnal',
                        style: redTextStyle.copyWith(
                            fontWeight: normal, fontSize: 12.h, color: black),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/images/eye.png",
                        width: 30.h,
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(grey),
                  ),
                  onPressed: () {
                    // Logika aksi tombol
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Simpan ke PDF',
                          style: redTextStyle.copyWith(
                              fontWeight: normal,
                              fontSize: 12.h,
                              color: black)),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/images/print.png",
                        width: 30.h,
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: GridView(
              padding: EdgeInsets.only(left: 10.h, top: 10.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.h,
                mainAxisSpacing: 10.h,
              ),
              children: [
                listCardWidget(
                  text1: 'Kelahiranku',
                  image: 'assets/images/kelahiranku.png',
                  onTap: () {
                    controller.navigateTo('kelahiranku');
                  },
                ),
                listCardWidget(
                    text1: 'Stimulasi perkembangan',
                    image: 'assets/images/stimulus.png',
                    onTap: () => controller.navigateTo('stimulus')),
                listCardWidget(
                    text1: 'Catatan',
                    image: 'assets/images/notepad 1.png',
                    onTap: () => Get.to(() => const MyDiaryView(),
                        binding: MyDiaryBinding())),
                listCardWidget(
                    text1: 'Catatan',
                    image: 'assets/images/notepad 1.png',
                    onTap: () => Get.to(() => const MyDiaryView(),
                        binding: MyDiaryBinding())),
              ],
            ),
          )
        ],
      ),
    );
  }
}
