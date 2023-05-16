import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/modules/profile_keluarga/views/profile_keluarga_view.dart';

import '../../../data/common/widget/logo_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverAppBar(
              username: _auth.currentUser?.displayName ?? 'tamu',
              expandedHeight: 200.0.h,
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 20.h)),
          SliverPadding(
            padding: EdgeInsets.only(left: 40.h, right: 40.h),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  mainAxisSpacing: 30.h,
                  crossAxisSpacing: 30.h),
              delegate: SliverChildListDelegate([
                listCardWidget(
                    text1: 'Catatan', image: 'assets/images/notepad 1.png'),
                listCardWidget(text1: 'Budi', image: 'assets/images/son.png'),
                listCardWidget(
                    text1: 'Ani', image: 'assets/images/daughter.png'),
                listCardWidget(text1: 'Budi', image: 'assets/images/son.png'),
                listCardWidget(
                    text1: 'Ani', image: 'assets/images/daughter.png'),
                listCardWidget(text1: 'Budi', image: 'assets/images/son.png'),
                listCardWidget(
                    text1: 'Ani', image: 'assets/images/daughter.png'),
                listCardWidget(text1: 'Budi', image: 'assets/images/son.png'),
                listCardWidget(
                    text1: 'Ani', image: 'assets/images/daughter.png'),
                listCardWidget(
                    text1: 'Tambah anak', image: 'assets/images/+.png'),
              ]),
            ),
          )
        ],
      ),
    ));
  }

  Widget listCardWidget({required String text1, required image}) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //custom widgets
                  Image.asset(image),
                ]),
          )),
          Container(
              height: 30.h,
              decoration: BoxDecoration(
                  color: background,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Center(
                  child: Text(
                text1,
                style: redTextStyle.copyWith(
                    fontWeight: normal, fontSize: 13.0.sp, color: white),
              )))
        ]));
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight; // Tinggi yang diperluas dari app bar
  final bool
      hideTitleWhenExpanded; // Apakah judul harus disembunyikan saat diperluas

  var username = '';

  MySliverAppBar({
    required this.expandedHeight,
    required this.username,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset; // Ukuran app bar saat ini
    final cardTopPosition =
        expandedHeight / 2 - shrinkOffset; // Posisi atas kartu saat ini
    final proportion = 2 -
        (expandedHeight /
            appBarSize); // Proporsi berdasarkan perubahan tinggi app bar
    final percent = proportion < 0 || proportion > 1
        ? 0.0
        : proportion; // Persentase berdasarkan proporsi
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              centerTitle: true,
              backgroundColor: background,
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16))),
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: const LogoWidget()),
            ),
          ),
          Positioned(
            top: 10.sp,
            left: 40.h,
            child: Opacity(
              opacity: percent,
              child: const LogoWidget(),
            ),
          ),
          Positioned(
              top: 55.h,
              left: 40.h,
              child: Opacity(
                opacity: percent,
                child: Text("Hello mom $username",
                    style:
                        redTextStyle.copyWith(fontWeight: bold, color: black)),
              )),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SizedBox(
                    height: expandedHeight,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100.h,
                          width: 100.w,
                          child: Image.asset('assets/images/photo1.png'),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          "Yuk moms isi profil keluarga dulu >.<",
                          style: redTextStyle.copyWith(
                              fontSize: 14.0.sp,
                              color: black,
                              fontWeight: normal),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        SizedBox(
                          height: 30.h,
                          child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(backgroundColor: red),
                            onPressed: () {
                              Get.to(const ProfileKeluargaView());
                            },
                            child: Text("isi profil keluarga",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: white,
                                    fontWeight: normal)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
