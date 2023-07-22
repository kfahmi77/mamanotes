import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/common/widget/logo_widget.dart';
import 'package:mamanotes/app/modules/kenangan/views/kenangan_detail_view.dart';
import 'package:mamanotes/app/modules/kenangan/views/kolase_foto_view.dart';

import '../controllers/kenangan_controller.dart';

class KenanganView extends GetView<KenanganController> {
  KenanganView({Key? key}) : super(key: key);

  final _isSearchVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    Get.put(KenanganController());
    return Scaffold(
      appBar: AppBar(
        title: Obx(() =>
            _isSearchVisible.value ? _buildSearchField() : const LogoWidget()),
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
              child: Obx(
                () {
                  if (controller.isLoading.isTrue) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (controller.isLoading.isFalse &&
                      controller.dataList.isNotEmpty) {
                    final groupedData = groupBy(
                        controller.dataList,
                        (data) => DateFormat('d MMMM yyyy', 'id_ID')
                            .format(data.createdAt.toDate()));
                    final keys = groupedData.keys.toList()
                      ..sort((a, b) => a.compareTo(b))
                      ..toList();
                    return ListView.builder(
                        itemCount: groupedData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final key = keys[index];
                          final values = groupedData[key];
                          return Row(children: [
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
                                      )
                              ],
                            ),
                            SizedBox(
                              height: 180.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
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
                                      height: 200.h,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 300.w,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: values?.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final data = values![index];
                                                return Hero(
                                                  tag:
                                                      'detailKenangan+${data.imageUrl}}',
                                                  child: GestureDetector(
                                                    onTap: () => Get.to(
                                                      () => KenanganDetailView(
                                                          imageUrl:
                                                              data.imageUrl),
                                                    ),
                                                    child: Card(
                                                      child: Stack(
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl:
                                                                data.imageUrl,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.56,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                1,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.56,
                                                              height: 20.h,
                                                              color: black
                                                                  .withOpacity(
                                                                      0.4),
                                                              child: Center(
                                                                child: Text(
                                                                  data.caption,
                                                                  style: redTextStyle.copyWith(
                                                                      fontSize:
                                                                          15.0
                                                                              .r,
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
                          ]);
                        });
                  } else {
                    if (controller.searchController.text.isNotEmpty) {
                      return Center(
                        child: Text(
                          "Data tidak ditemukan",
                          style: redTextStyle.copyWith(
                              fontSize: 16.sp, fontWeight: bold, color: red),
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/images/no_data.zip',
                            ),
                            Text(
                              "Buat kenanganmu yuk bunda :)",
                              style: redTextStyle.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: bold,
                                  color: red),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KolaseFotoView(),
            ),
          );
          // Get.toNamed(Routes.addKenangan);
        },
        child: Image.asset(
          'assets/images/tambah_icon.png',
          width: 80.w,
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      IconButton(
        icon: FaIcon(
          _isSearchVisible.value
              ? FontAwesomeIcons.x
              : FontAwesomeIcons.magnifyingGlass,
          color: red,
        ),
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
            decoration: InputDecoration(
              hintText: 'Cari',
              hintStyle: TextStyle(color: red),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              controller.search(value);
            },
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.clear,
            color: red,
          ),
          onPressed: () {
            controller.clearSearch();
          },
        ),
      ],
    );
  }
}
