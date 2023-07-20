import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/merangkak_anak/models/merangkak_anak_model.dart';

import '../../../../data/common/style.dart';
import '../../../../data/common/widget/detail_foto_widget.dart';
import '../controllers/merangkak_anak_controller.dart';
import 'edit_merangkak_anak_view.dart';

class MerangkakView extends GetView<MerangkakAnakController> {
  const MerangkakView({super.key});

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
                  'Tidak ada foto anak merangkak',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: red),
                  onPressed: () => controller.navigateToAddStimulusAnakView(),
                  child: const Text('Tambah Data'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MerangkakAnakView extends StatelessWidget {
  final MerangkakAnakModel merangkakAnak;

  const MerangkakAnakView({super.key, required this.merangkakAnak});

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
                Get.to(() => EditMerangkakAnakView(
                      merangkakAnak: merangkakAnak,
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
                    "Anak Merangkak",
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
                            urlImage: merangkakAnak.imageUrl,
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
                        imageUrl: merangkakAnak.imageUrl,
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
