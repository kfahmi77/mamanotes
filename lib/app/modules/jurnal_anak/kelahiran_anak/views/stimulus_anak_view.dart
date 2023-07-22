import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';

import '../../../../data/common/widget/custom_card.dart';
import '../../../../data/common/widget/detail_foto_widget.dart';
import '../controllers/kelahiran_anak_controller.dart';
import '../models/kelahiran_anak_model.dart';
import 'add_jurnal_kelahiran_anak_view.dart';
import 'edit_kelahiran_anak.dart';

class KelahiranView extends GetView<StimulusAnakController> {
  const KelahiranView({super.key});

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
      body: FutureBuilder<void>(
        future: controller.fetchData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(red),
                  ),
                  onPressed: () => controller.navigateToAddStimulusAnakView(),
                  child: const Text('Tambah Kelahiran Anak'),
                ),
              ],
            ),
          );
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: red,
        title: Text(
          'MAMANOTE',
          style: redTextStyle.copyWith(
              fontWeight: bold, fontSize: 20.sp, color: white),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => EditKelahiranAnakView(
                  kelahiranAnak: kelahiranAnak,
                )),
            icon: Icon(
              FontAwesomeIcons.penToSquare,
              size: 24.sp,
            ),
          ),
        ],
      ),
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
                    subtitle: kelahiranAnak.waktuLahir,
                    iconData: Icons.access_time,
                    backgroundColor: red,
                    textColor: white),
                Expanded(
                  child: CustomCard(
                      title: 'Tempat Lahir',
                      subtitle: kelahiranAnak.tempatLahir,
                      iconData: Icons.place,
                      backgroundColor: red,
                      textColor: white),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(
                    title: 'Tinggi Badan',
                    subtitle: '${kelahiranAnak.tinggiAnakLahir}cm',
                    iconData: FontAwesomeIcons.ruler,
                    backgroundColor: red,
                    textColor: white),
                CustomCard(
                    title: 'Berat Badan',
                    subtitle: '${kelahiranAnak.beratAnakLahir} kg',
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
                    subtitle: kelahiranAnak.petugasKesehatan,
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
                    subtitle: kelahiranAnak.doaIbu,
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
                    subtitle: kelahiranAnak.doaAyah,
                    iconData: FontAwesomeIcons.person,
                    backgroundColor: red,
                    textColor: white),
              ),
            ),
            const SizedBox(height: 16.0),
            CarouselSlider(
              items: [
                buildImageStack(
                  kelahiranAnak.urlFotoAnak,
                  'Foto Anak Lahir',
                  onTap: () => Get.to(() => DetailFotoView(
                        urlImage: kelahiranAnak.urlFotoAnak,
                      )),
                ),
                buildImageStack(
                    kelahiranAnak.urlFotoCapKaki, 'Foto Cap Kaki Anak',
                    onTap: () => Get.to(() => DetailFotoView(
                          urlImage: kelahiranAnak.urlFotoCapKaki,
                        ))),
                buildImageStack(
                  kelahiranAnak.urlFotoKelahiran,
                  onTap: () => Get.to(() => DetailFotoView(
                        urlImage: kelahiranAnak.urlFotoKelahiran,
                      )),
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

Widget buildImageStack(String imageUrl, String labelText,
    {required Future? Function() onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
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
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
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
      ));
}
