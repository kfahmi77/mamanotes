import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/common/utils/date_formatter.dart';
import 'package:mamanotes/app/modules/data_anak/controllers/detail_anak_controller.dart';
import 'package:mamanotes/app/modules/jurnal_anak/berdiri_anak/views/berdiri_anak_view.dart';
import 'package:mamanotes/app/modules/jurnal_anak/bulan_pertama_anak/bindings/bulan_pertama_anak_binding.dart';
import 'package:mamanotes/app/modules/jurnal_anak/bulan_pertama_anak/views/bulan_pertama_anak_view.dart';
import 'package:mamanotes/app/modules/jurnal_anak/duduk_anak/bindings/duduk_anak_binding.dart';
import 'package:mamanotes/app/modules/jurnal_anak/duduk_anak/views/duduk_anak_view.dart';
import 'package:mamanotes/app/modules/jurnal_anak/gigi_pertama_anak/bindings/gigi_pertama_anak_binding.dart';
import 'package:mamanotes/app/modules/jurnal_anak/gigi_pertama_anak/views/gigi_pertama_anak_view.dart';
import 'package:mamanotes/app/modules/jurnal_anak/merangkak_anak/bindings/merangkak_anak_binding.dart';
import 'package:mamanotes/app/modules/jurnal_anak/merangkak_anak/views/merangkak_anak_view.dart';
import 'package:mamanotes/app/modules/jurnal_anak/tahun_pertama_anak/bindings/tahun_pertama_anak_binding.dart';
import 'package:mamanotes/app/modules/jurnal_anak/tahun_pertama_anak/views/tahun_pertama_anak_view.dart';
import 'package:mamanotes/app/modules/jurnal_anak/kata_pertama_anak/bindings/kata_pertama_anak_binding.dart';
import '../../../data/common/widget/card_list_widget.dart';
import '../../home/models/anak_model.dart';
import '../../jurnal_anak/berdiri_anak/bindings/berdiri_anak_binding.dart';
import '../../jurnal_anak/kelahiran_anak/bindings/stimulus_anak_binding.dart';
import '../../jurnal_anak/kelahiran_anak/views/stimulus_anak_view.dart';
import '../../jurnal_anak/pdf_view.dart';
import '../../jurnal_anak/kata_pertama_anak/views/kata_pertama_anak_view.dart';
import 'edit_data_anak_view.dart';

class DetailAnakView extends GetView<DetailAnakController> {
  final String anakId;
  const DetailAnakView({Key? key, required this.anakId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                          selectedAnak); // Perbarui selectedAnak dengan anak yang baru dipilih
                      Get.off(() => DetailAnakView(anakId: selectedAnak.docId));
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
                                        CachedNetworkImage(
                                          imageUrl: anak.fotoAnak,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            backgroundImage: imageProvider,
                                            radius: 15.0,
                                          ),
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        const SizedBox(width: 10.0),
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
          JurnalPdfWidget(
            documentId: anakId,
          ),
          SizedBox(
            height: 8.h,
          ),
          GridJurnalWidget(
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
    required this.anakId,
  });
  final String anakId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailAnakController>();
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
              Get.to(() => const KelahiranView(),
                  binding: StimulusAnakBinding(
                      documentId: controller.getSelectedAnak()?.docId ?? anakId,
                      jurnalAnakId:
                          'kelahiranAnak${controller.getSelectedAnak()?.docId ?? anakId}'));
            },
          ),
          listCardWidget(
            text1: 'Kata Pertamaku',
            image: 'assets/images/first_word.png',
            onTap: () {
              Get.to(() => const KataPertamaView(),
                  binding: KataPertamaAnakBinding(
                      documentId: controller.getSelectedAnak()?.docId ?? anakId,
                      kataPertamaAnakId:
                          'kataAnakPertama${controller.getSelectedAnak()?.docId ?? anakId}'));
            },
          ),
          listCardWidget(
            text1: 'Gigi Pertamaku',
            image: 'assets/images/gigi.png',
            onTap: () {
              Get.to(() => const GigiPertamaView(),
                  binding: GigiPertamaAnakBinding(
                      documentId: controller.getSelectedAnak()?.docId ?? anakId,
                      gigiPertamaAnakId:
                          'gigiPertamaAnak${controller.getSelectedAnak()?.docId ?? anakId}'));
            },
          ),
          listCardWidget(
            text1: 'Merangkak',
            image: 'assets/images/crawling.png',
            onTap: () {
              Get.to(() => const MerangkakView(),
                  binding: MerangkakAnakBinding(
                      documentId: controller.getSelectedAnak()?.docId ?? anakId,
                      merangkakAnakId:
                          'merangkakAnakId${controller.getSelectedAnak()?.docId ?? anakId}'));
            },
          ),
          listCardWidget(
            text1: 'Duduk',
            image: 'assets/images/sit.png',
            onTap: () {
              Get.to(() => const DudukView(),
                  binding: DudukAnakBinding(
                      documentId: controller.getSelectedAnak()?.docId ?? anakId,
                      dudukAnakId:
                          'dudukAnakId${controller.getSelectedAnak()?.docId ?? anakId}'));
            },
          ),
          listCardWidget(
            text1: 'Berdiri',
            image: 'assets/images/walk.png',
            onTap: () {
              Get.to(() => const BerdiriView(),
                  binding: BerdiriAnakBinding(
                      documentId: controller.getSelectedAnak()?.docId ?? anakId,
                      berdiriAnakId:
                          'D${controller.getSelectedAnak()?.docId ?? anakId}'));
            },
          ),
          listCardWidget(
            text1: 'Bulan Pertamaku',
            image: 'assets/images/calendar.png',
            onTap: () {
              Get.to(() => const BulanPertamaAnak(),
                  binding: BulanPertamaAnakBinding(
                      documentId: controller.getSelectedAnak()?.docId ?? anakId,
                      bulanPertamaAnakId:
                          'bulanPertamaAnakId${controller.getSelectedAnak()?.docId ?? anakId}'));
            },
          ),
          listCardWidget(
            text1: 'Tahun Pertamaku',
            image: 'assets/images/years.png',
            onTap: () {
              Get.to(() => const TahunPertamaAnak(),
                  binding: TahunPertamaAnakBinding(
                      documentId: controller.getSelectedAnak()?.docId ?? anakId,
                      tahunPertamaAnakId:
                          'tahunPertamaAnakId${controller.getSelectedAnak()?.docId ?? anakId}'));
            },
          ),
        ],
      ),
    );
  }
}

class JurnalPdfWidget extends StatelessWidget {
  const JurnalPdfWidget({
    super.key,
    required this.documentId,
  });
  final String documentId;

  @override
  Widget build(BuildContext context) {
    DetailAnakController controller = Get.put(DetailAnakController());
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PdfPreviewPage(
                  documentId: controller.getSelectedAnak()?.docId ?? documentId,
                );
              }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: red, width: 4.r),
              borderRadius: BorderRadius.circular(4.r),
            ),
            width: 320.w,
            height: 200.h,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: anak.fotoAnak,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Image.network(
                //   anak.fotoAnak,
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                //   height: double.infinity,
                // ),
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
