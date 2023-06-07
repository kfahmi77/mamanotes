import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/common/utils/date_formatter.dart';
import 'package:mamanotes/app/modules/data_anak/controllers/detail_anak_controller.dart';
import 'package:mamanotes/app/modules/jurnal_anak/controllers/jurnal_anak_controller.dart';

import '../../../data/common/widget/card_list_widget.dart';
import '../../home/models/anak_model.dart';
import '../../kelahiran_anak/views/stimulus_anak_view.dart';
import 'edit_data_anak_view.dart';

class DetailAnakView extends GetView<DetailAnakController> {
  final String anakId;
  const DetailAnakView({Key? key, required this.anakId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    JurnalAnakController jurnalController = Get.find<JurnalAnakController>();
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Text(
            'Detail Anak',
            style:
                redTextStyle.copyWith(color: white, fontWeight: superExtraBold),
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('anak')
                    .where('uid', isEqualTo: user!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Icon(
                      Icons.error,
                      color: Colors.white,
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  List<AnakModel> anakList =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return AnakModel.fromJson(data);
                  }).toList();

                  return PopupMenuButton<AnakModel>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    icon: Image.asset(
                      "assets/images/switch_anak.png",
                      width: 30.0.w,
                      height: 30.0.h,
                    ),
                    onSelected: (AnakModel selectedAnak) {
                      controller.setSelectedAnak(
                          selectedAnak); // Set the selected AnakModel object
                      Get.to(() => DetailAnakView(anakId: anakId));
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<AnakModel>>[
                        PopupMenuItem<AnakModel>(
                          child: SizedBox(
                            height: 110.h, // Tinggi maksimum PopupMenu
                            child: SingleChildScrollView(
                              child: Column(
                                children: anakList.map((AnakModel anak) {
                                  return PopupMenuItem<AnakModel>(
                                    value: anak,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              anak.fotoAnak), // Gambar avatar
                                          radius: 15.0,
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          anak.namaLengkap.length > 20
                                              ? '${anak.namaLengkap.substring(0, 15)}...' // Display only the first 10 characters with ellipsis
                                              : anak.namaLengkap,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                  );
                },
              ))
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
          Obx(() {
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('anak')
                  .doc(controller.getSelectedAnak()?.docId ?? anakId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  return const Text('Data not found');
                }

                AnakModel anak = AnakModel.fromJson(
                    snapshot.data!.data() as Map<String, dynamic>);

                return CardAnakWidget(anak: anak);
              },
            );
          }),
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
          const JurnalPdfWidget(),
          SizedBox(
            height: 8.h,
          ),
          GridJurnalWidget(
            jurnalController: jurnalController,
            anakId: anakId,
          )
        ],
      ),
    );
  }
}

class GridJurnalWidget extends StatelessWidget {
  const GridJurnalWidget({
    super.key,
    required this.jurnalController,
    required this.anakId,
  });
  final String anakId;
  final JurnalAnakController jurnalController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              Get.to(() => StimulusAnakView(
                    documentId: anakId,
                  ));
            },
          ),
          // listCardWidget(
          //   text1: 'Kelahiranku',
          //   image: 'assets/images/kelahiranku.png',
          //   onTap: () {
          //     jurnalController.navigateTo('kelahiranku');
          //   },
          // ),
          // listCardWidget(
          //     text1: 'Stimulasi ',
          //     image: 'assets/images/stimulus.png',
          //     onTap: () => jurnalController.navigateTo('stimulus')),
          // listCardWidget(
          //     text1: 'Catatan',
          //     image: 'assets/images/notepad 1.png',
          //     onTap: () =>
          //         Get.to(() => const MyDiaryView(), binding: MyDiaryBinding())),
          // listCardWidget(
          //     text1: 'Catatan',
          //     image: 'assets/images/notepad 1.png',
          //     onTap: () =>
          //         Get.to(() => const MyDiaryView(), binding: MyDiaryBinding())),
        ],
      ),
    );
  }
}

class JurnalPdfWidget extends StatelessWidget {
  const JurnalPdfWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                        fontWeight: normal, fontSize: 12.h, color: black)),
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
    );
  }
}

class CardAnakWidget extends StatelessWidget {
  const CardAnakWidget({
    super.key,
    required this.anak,
  });

  final AnakModel anak;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            width: 320.w,
            height: 200.h,
            child: Stack(
              children: [
                Image.network(
                  anak.fotoAnak,
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
                        color: red.withOpacity(0.7),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            anak.namaPanggilan,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${anak.tempat} ${formatTanggalLahir(anak.tanggalLahir.toDate())}',
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
                        Get.to(() => EditDataAnakView(anak: anak));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
