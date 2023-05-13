import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/common/widget/title_image_appbar.dart';

import '../../../routes/app_pages.dart';
import '../controllers/kenangan_controller.dart';

class KenanganView extends GetView<KenanganController> {
  KenanganView({Key? key}) : super(key: key);

  final _isSearchVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    Get.put(KenanganController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => _isSearchVisible.value
            ? _buildSearchField()
            : const BuildLogoWidget()),
        automaticallyImplyLeading: false,
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        actions: _buildActions(),
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
              child: Obx(() {
                if (controller.dataList.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final groupedData = groupBy(
                      controller.dataList,
                      (data) => DateFormat('d MMM yy', 'id_ID')
                          .format(data.createdAt.toDate()));
                  final keys = groupedData.keys.toList()
                    ..sort((a, b) => a.compareTo(b))
                    ..reversed.toList();
                  return ListView.builder(
                    itemCount: groupedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final key = keys[index];
                      final values = groupedData[key];
                      return Row(
                        children: [
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
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
                              //ganti panjang data dari firebase
                              index == groupedData.length - 1
                                  ? Container(
                                      height: 150.h,
                                      width: 5.w,
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                    )
                                  : Container(
                                      height: 150.h,
                                      width: 5.w,
                                      decoration: BoxDecoration(color: red),
                                      // final RxList<KenanganModel> _daftarKenangan = RxList<KenanganModel>([]);

                                      // List<KenanganModel> get daftarKenangan => _daftarKenangan;                    )
                                    )
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
                                          key,
                                          style: redTextStyle.copyWith(
                                            fontSize: 14.0,
                                          ),
                                        ),
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
                                              itemCount: values?.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final data = values![index];
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
                                                          child: Image.network(
                                                            data.imageUrl,
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
                                                                data.caption,
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
                    },
                  );
                }
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Get.toNamed(Routes.addKenangan);
        },
        child: Image.asset(
          'assets/images/plus_icon.png',
          width: 80.w,
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      IconButton(
        icon: FaIcon(_isSearchVisible.value
            ? FontAwesomeIcons.x
            : FontAwesomeIcons.magnifyingGlass),
        onPressed: () {
          _isSearchVisible.toggle();
        },
      ),
    ];
  }

  Widget _buildSearchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.searchController,
            decoration: const InputDecoration(
              hintText: 'Cari',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              controller.search(value);
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.clearSearch();
          },
        ),
      ],
    );
  }
}
