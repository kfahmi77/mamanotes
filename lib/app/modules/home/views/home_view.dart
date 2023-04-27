import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverAppBar(expandedHeight: 200.0.h),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 120.r)),
          SliverPadding(
            padding: EdgeInsets.only(left: 40.r, right: 40.r),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30),
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
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            color: background,
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: SizedBox(
                height: 30.h,
                child: Image.asset('assets/images/logo_mamanote.png')),
          ),
        ),
        Positioned(
            child: Opacity(
          opacity: 1 - shrinkOffset / expandedHeight,
        )),
        Positioned(
          top: 10.sp,
          left: MediaQuery.of(context).size.width / 14,
          child: Opacity(
            opacity: 1 - shrinkOffset / expandedHeight,
            child: SizedBox(
              height: 30.h,
              child: Image.asset('assets/images/logo_mamanote.png'),
            ),
          ),
        ),
        Positioned(
            top: 55.r,
            left: MediaQuery.of(context).size.width / 14,
            child: Opacity(
              opacity: 1 - shrinkOffset / expandedHeight,
              child: Text("Hello moms",
                  style: redTextStyle.copyWith(fontWeight: bold, color: black)),
            )),
        Positioned(
          top: expandedHeight / 3 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 14,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              children: [
                SizedBox(
                  height: 30.r,
                ),
                Card(
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
                              fontSize: 14.0, color: black, fontWeight: normal),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        SizedBox(
                          height: 30.h,
                          child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(backgroundColor: red),
                            onPressed: () {},
                            child: const Text("isi profil keluarga"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
