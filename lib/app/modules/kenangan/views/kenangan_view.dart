import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';

import '../controllers/kenangan_controller.dart';

class MenuItem {
  final String title;
  final String date;
  final String image;

  MenuItem({required this.title, required this.date, required this.image});
}

class KenanganView extends GetView<KenanganController> {
  KenanganView({Key? key}) : super(key: key);
  final List<MenuItem> menuItems = [
    MenuItem(
      title: 'Menu Item 1',
      date: '27 April 2023',
      image: 'assets/images/menu_item_1.png',
    ),
    MenuItem(
      title: 'Menu Item 2',
      date: '28 April 2023',
      image: 'assets/images/menu_item_2.png',
    ),
    MenuItem(
      title: 'Menu Item 3',
      date: '29 April 2023',
      image: 'assets/images/menu_item_3.png',
    ),
    MenuItem(
      title: 'Menu Item 4',
      date: '30 April 2023',
      image: 'assets/images/menu_item_4.png',
    ),
    MenuItem(
      title: 'Menu Item 5',
      date: '1 Mei 2023',
      image: 'assets/images/menu_item_5.png',
    ),
  ];

  final List<Map<String, dynamic>> timelineData = [
    {
      'title': 'Pesanan Diterima',
      'date': '25 Apr 2023',
      'icon': Icons.check,
      'color': Colors.green,
    },
    {
      'title': 'Sedang Dikirim',
      'date': '26 Apr 2023',
      'icon': Icons.local_shipping,
      'color': Colors.grey[400],
    },
    {
      'title': 'Diterima',
      'date': '27 Apr 2023',
      'icon': Icons.home,
      'color': Colors.grey[400],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo_mamanote.png",
            width: 150.w,
            fit: BoxFit.cover,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: background,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.r)),
            Text(
              "Kenangan",
              style: redTextStyle.copyWith(
                  fontSize: 16.sp, fontWeight: bold, color: red),
            ),
            Divider(
                height: 20,
                thickness: 5,
                indent: 100.r,
                endIndent: 100.r,
                color: red),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 0, 0),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.circle,
                                    color: red,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 150.h,
                                width: 5.w,
                                decoration: BoxDecoration(color: red),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 160.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.r),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "20 Oktober 2022",
                                          style: redTextStyle.copyWith(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.r)),
                                        Text(
                                          "Bandung, Jawa Barat",
                                          style: redTextStyle.copyWith(
                                              fontSize: 14.0,
                                              fontWeight: semiBold),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 5.r)),
                                        FaIcon(
                                          FontAwesomeIcons.locationDot,
                                          color: red,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 200.0.h,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 300.0.w,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 10,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(
                                                  width: 200.0.w,
                                                  child: Card(
                                                    color: grey,
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 30,
                                                                  left: 20),
                                                          child: Image.asset(
                                                            "assets/images/son.png",
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Container(
                                                            width: 200.w,
                                                            height: 20.h,
                                                            color: black
                                                                .withOpacity(
                                                                    0.4),
                                                            child: Center(
                                                              child: Text(
                                                                "Kenangan",
                                                                style: redTextStyle.copyWith(
                                                                    fontSize:
                                                                        15.0.r,
                                                                    fontWeight:
                                                                        semiBold,
                                                                    color:
                                                                        white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
