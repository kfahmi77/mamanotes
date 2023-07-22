import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/common/style.dart';
import '../controllers/tentang_controller.dart';

class TentangView extends GetView<TentangController> {
  const TentangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: const Text('Tentang Kami'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: 250.h,
        child: Card(
          color: red,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Mamanote adalah aplikasi yang dibuat untuk membantu orang tua dalam mencatat perkembangan anaknya. Tujuan dari aplikasi ini adalah untuk membantu orang tua dalam mencatat perkembangan anaknya. Dengan adanya aplikasi ini, orang tua dapat mencatat perkembangan anaknya secara digital dan dapat diakses kapanpun dan dimanapun.',
                      style: redTextStyle.copyWith(
                          fontSize: 16.sp, fontWeight: normal, color: white),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
