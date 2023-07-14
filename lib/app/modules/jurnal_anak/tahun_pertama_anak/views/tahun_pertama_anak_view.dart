import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/bulan_pertama_anak/models/bulan_pertama_anak_model.dart';
import 'package:mamanotes/app/modules/jurnal_anak/tahun_pertama_anak/models/tahun_pertama_anak_model.dart';

import '../../../../data/common/style.dart';
import '../../../../data/common/widget/detail_foto_widget.dart';
import '../controllers/tahun_pertama_anak_controller.dart';
import 'edit_tahun_pertama_anak_view.dart';

class TahunPertamaAnak extends GetView<TahunPertamaAnakController> {
  const TahunPertamaAnak({super.key});

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
                  'Tidak ada data tahun pertama anak',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: red),
                  onPressed: () => controller.navigateToAddStimulusAnakView(),
                  child: const Text('Tambah  Data Tahun Pertama Anak'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TahunPertamaAnakView extends StatelessWidget {
  final TahunPertamaAnakModel tahunPertamaAnak;

  const TahunPertamaAnakView({super.key, required this.tahunPertamaAnak});

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
              onPressed: () {
                Get.to(() => EditTahunPertamaAnakView(
                      tahunPertamaAnak: tahunPertamaAnak,
                    ));
              },
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
                    "Bulan Pertama Anak",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DetailFotoView(
                            urlImage: tahunPertamaAnak.imageUrl,
                          ));
                    },
                    child: Container(
                      width: 300.w,
                      height: 300.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: red, width: 2.r),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: tahunPertamaAnak.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
