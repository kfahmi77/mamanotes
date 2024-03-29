import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style.dart';

Widget listCardNetworAnakkWidget(
    {required String text1, required image, required Function() onTap}) {
  return InkWell(
    onTap: () => onTap(),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Custom widgets
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        fit: BoxFit
                            .cover, // Make the image fill the available space
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30.h,
            decoration: BoxDecoration(
              color: red,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                text1,
                style: redTextStyle.copyWith(
                  fontWeight: normal,
                  fontSize: 13.0.sp,
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget listCardWidget(
    {required String text1, required image, required Function() onTap}) {
  return InkWell(
    onTap: () => onTap(),
    child: Card(
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
                  color: red,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Center(
                  child: Text(
                text1,
                style: redTextStyle.copyWith(
                    fontWeight: normal, fontSize: 13.0.sp, color: white),
              )))
        ])),
  );
}
