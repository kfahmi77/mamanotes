import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/modules/data_anak/bindings/data_anak_binding.dart';
import 'package:mamanotes/app/modules/data_anak/views/data_anak_view.dart';
import 'package:mamanotes/app/modules/data_anak/views/detail_data_anak_view.dart';
import 'package:mamanotes/app/modules/home/models/anak_model.dart';
import 'package:mamanotes/app/modules/my_diary/bindings/my_diary_binding.dart';
import 'package:mamanotes/app/modules/my_diary/views/my_diary_view.dart';
import 'package:mamanotes/app/modules/profile_keluarga/views/profile_keluarga_view.dart';

import '../../../data/common/widget/card_list_widget.dart';
import '../../../data/common/widget/logo_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final HomeController homeController = Get.put(HomeController());
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
          SliverPadding(padding: EdgeInsets.only(top: 10.h)),
          SliverPadding(
            padding: EdgeInsets.only(left: 40.h, right: 40.h),
            sliver: GetBuilder<HomeController>(
              init: homeController,
              builder: (controller) {
                return StreamBuilder<List<AnakModel>>(
                  stream: controller.getMenuItems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<AnakModel>? menuItems = snapshot.data;
                      if (menuItems != null && menuItems.isNotEmpty) {
                        return SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (index == 0) {
                                // Widget pertama
                                return listCardWidget(
                                    text1: 'Catatan',
                                    image: 'assets/images/notepad 1.png',
                                    onTap: () {
                                      Get.to(() => const MyDiaryView(),
                                          binding: MyDiaryBinding(),
                                          transition: Transition.rightToLeft);
                                    });
                              } else if (index == menuItems.length + 1) {
                                // Widget terakhir
                                return listCardWidget(
                                    text1: 'Tambah Anak',
                                    image: 'assets/images/plus.png',
                                    onTap: () => Get.to(
                                          () => const TambahDataAnakView(),
                                          binding: DataAnakBinding(),
                                          transition:
                                              Transition.leftToRightWithFade,
                                        ));
                              } else {
                                // Index di antara listCardWidget
                                int menuItemIndex = index - 1;
                                AnakModel menuItem = menuItems[menuItemIndex];
                                return GridTile(
                                  child: listCardNetworAnakkWidget(
                                    text1: menuItem.namaPanggilan,
                                    image: menuItem.fotoAnak,
                                    onTap: () {
                                      debugPrint(menuItem.docId);
                                      Get.to(
                                        () => DetailAnakView(
                                            anakId: menuItem.docId),
                                        binding: DataAnakBinding(),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            childCount: menuItems.length +
                                2, // Jumlah total item termasuk widget lain
                          ),
                        );
                      } else {
                        return SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            delegate: SliverChildListDelegate([
                              listCardWidget(
                                  text1: 'Catatan',
                                  image: 'assets/images/notepad 1.png',
                                  onTap: () {
                                    Get.to(() => const MyDiaryView(),
                                        binding: MyDiaryBinding(),
                                        transition: Transition.rightToLeft);
                                  }),
                              listCardWidget(
                                  text1: 'Tambah Anak',
                                  image: 'assets/images/plus.png',
                                  onTap: () => Get.to(
                                        () => const TambahDataAnakView(),
                                        binding: DataAnakBinding(),
                                        transition:
                                            Transition.leftToRightWithFade,
                                      )),
                            ]));
                      }
                    } else if (snapshot.hasError) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: Text('Error fetching menu items'),
                        ),
                      );
                    } else {
                      return const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    ));
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
    User? user = FirebaseAuth.instance.currentUser;
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
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('keluarga')
                          .where('uid', isEqualTo: user!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          ); // Show a loading indicator while waiting for the data
                        }

                        if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                          ); // Show an error message if there's an error
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          // Check if there's no data or the snapshot's data list is empty
                          return Column(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.asset('assets/images/photo1.png'),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              const Text(
                                "Yuk moms isi profil keluarga dulu >.<",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: red,
                                  ),
                                  onPressed: () {
                                    Get.to(const ProfileKeluargaView());
                                  },
                                  child: const Text(
                                    "isi profil keluarga",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        // If data is available, display the content for the family profile
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(22.h),
                                topRight: Radius.circular(22.h),
                              ),
                              child: AspectRatio(
                                aspectRatio:
                                    2.53.r, // Adjust the aspect ratio as needed
                                child: Image.asset(
                                  'assets/images/keluargaku.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: proportion <= (5 * 75.0) ? 10.h : 30.h,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 6)),
                            SizedBox(
                              height: 30.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: red,
                                ),
                                onPressed: () {
                                  Get.to(const ProfileKeluargaView());
                                },
                                child: Text(
                                  "profil keluargaku",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: white,
                                    fontWeight: normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
