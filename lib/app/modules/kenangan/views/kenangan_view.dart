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
                                10, 0, 0, 0),
                            child: Text(
                              "tanggal \n ${DateTime.now().day} \n ${DateTime.now().month} \n ${DateTime.now().year}  ",
                              style: redTextStyle.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: normal,
                                  color: black),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.circle,
                                    color: red,
                                  ),
                                ],
                              ),
                              Container(
                                height: 200.h,
                                width: 5.w,
                                decoration: BoxDecoration(color: red),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 180.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 200.0.h,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 230.0.w,
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
                                                                "text",
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
