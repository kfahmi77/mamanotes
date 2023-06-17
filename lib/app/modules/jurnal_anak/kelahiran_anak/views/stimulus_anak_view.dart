import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mamanotes/app/data/common/style.dart';

import '../../../../data/common/widget/custom_card.dart';
import '../models/kelahiran_anak_model.dart';
import 'add_jurnal_kelahiran_anak_view.dart';

class StimulusAnakView extends StatelessWidget {
  final String documentId;
  final String jurnalAnakId;

  const StimulusAnakView(
      {super.key, required this.documentId, required this.jurnalAnakId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: Text(
          'MAMANOTE',
          style: redTextStyle.copyWith(
              fontWeight: bold, fontSize: 20.sp, color: white),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('anak')
            .doc(documentId)
            .collection('jurnal_anak')
            .doc(jurnalAnakId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tidak ada data kelahiran anak',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke menu tambah kelahiran anak
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddStimulusAnakView(
                            kelahiranAnakId: jurnalAnakId,
                            anakId: documentId,
                          ),
                        ),
                      );
                    },
                    child: const Text('Tambah Kelahiran Anak'),
                  ),
                ],
              ),
            );
          }

          // Mendapatkan data dari Firestore
          final data = snapshot.data!.data()! as Map<String, dynamic>;
          final kelahiranAnak = KelahiranAnak.fromJson(data);

          return KelahiranAnakView(kelahiranAnak: kelahiranAnak);
        },
      ),
    );
  }
}

class KelahiranAnakView extends StatelessWidget {
  final KelahiranAnak kelahiranAnak;

  const KelahiranAnakView({super.key, required this.kelahiranAnak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kenangan",
                  style: redTextStyle.copyWith(
                      fontSize: 16.sp, fontWeight: bold, color: red),
                ),
              ],
            ),
            Divider(
                height: 20,
                thickness: 5,
                indent: 100.r,
                endIndent: 100.r,
                color: red),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(
                    title: 'Waktu Lahir',
                    subtitle: kelahiranAnak.birthTime,
                    iconData: Icons.access_time,
                    backgroundColor: red,
                    textColor: white),
                CustomCard(
                    title: 'Tempat Lahir',
                    subtitle: kelahiranAnak.birthPlace,
                    iconData: Icons.place,
                    backgroundColor: red,
                    textColor: white),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(
                    title: 'Tinggi Badan',
                    subtitle: '${kelahiranAnak.height}cm',
                    iconData: FontAwesomeIcons.ruler,
                    backgroundColor: red,
                    textColor: white),
                CustomCard(
                    title: 'Berat Badan',
                    subtitle: '${kelahiranAnak.weight} kg',
                    iconData: FontAwesomeIcons.weightScale,
                    backgroundColor: red,
                    textColor: white),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 14.w, top: 16.h),
              child: SizedBox(
                width: 300.w,
                child: CustomCard(
                    title: 'Dokter / Bidan',
                    subtitle: kelahiranAnak.medicalPersonnel,
                    iconData: FontAwesomeIcons.userDoctor,
                    backgroundColor: red,
                    textColor: white),
              ),
            ),
            SizedBox(height: 16.0.h),
            Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: SizedBox(
                width: 300.w,
                child: CustomCard(
                    title: 'Doa dari Bunda',
                    subtitle: kelahiranAnak.motherPrayer,
                    iconData: FontAwesomeIcons.personDress,
                    backgroundColor: red,
                    textColor: white),
              ),
            ),
            SizedBox(height: 16.0.h),
            Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: SizedBox(
                width: 300.w,
                child: CustomCard(
                    title: 'Doa dari Ayah',
                    subtitle: kelahiranAnak.fatherPrayer,
                    iconData: FontAwesomeIcons.person,
                    backgroundColor: red,
                    textColor: white),
              ),
            ),
            const SizedBox(height: 16.0),
            CarouselSlider(
              items: [
                _buildImageStack(
                  kelahiranAnak.birthPhotoUrl,
                  'Foto Anak Lahir',
                ),
                _buildImageStack(
                  kelahiranAnak.footPrintPhotoUrl,
                  'Foto Cap Kaki Anak',
                ),
                _buildImageStack(
                  kelahiranAnak.deliveryPhotoUrl,
                  'Foto Persalinan',
                ),
              ],
              options: CarouselOptions(
                height: 200.h,
                viewportFraction: 0.5, // Mengatur fraksi dari lebar viewport
                aspectRatio: 16 / 9, // Mengatur rasio aspek gambar
                enlargeCenterPage:
                    true, // Perbesar gambar saat ditampilkan di tengah
                enableInfiniteScroll: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildImageStack(String imageUrl, String labelText) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.black54,
          child: Text(labelText,
              style: redTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: bold,
                color: white,
              )),
        ),
      ),
    ],
  );
}