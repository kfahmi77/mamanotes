import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/kata_pertama_anak/models/kata_pertama_anak_model.dart';

import '../../../../data/common/style.dart';
import '../../../../data/common/utils/number_formatter.dart';
import '../../../../data/common/widget/custom_card.dart';
import '../controllers/kata_pertama_anak_controller.dart';
import 'add_kata_pertama_anak_view.dart';
import 'edit_kata_pertama_anak_view.dart';

class KataPertamaView extends GetView<KataPertamaAnakController> {
  const KataPertamaView({super.key});

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
                  'Tidak ada data kalimat pertama anak',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: red),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddKataPertamaAnakView(
                          documentId: controller.documentId,
                          kataPertamaAnakId: controller.kataPertamaAnakId,
                        ),
                      ),
                    );
                  },
                  child: Text('Tambah Data'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class KataPertamaAnakView extends GetView<KataPertamaAnakController> {
  final KataPertamaAnakModel kataPertamaAnak;

  const KataPertamaAnakView({super.key, required this.kataPertamaAnak});

  @override
  Widget build(BuildContext context) {
    KataPertamaAnakController controller =
        Get.find<KataPertamaAnakController>();

    final audioPlayer = controller.audioPlayer.value;

    Future<bool> handleBackNavigation() async {
      await audioPlayer.stop();
      return true; // Allow navigation back
    }

    return WillPopScope(
      onWillPop: handleBackNavigation,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: red,
          title: Text(
            'MAMANOTE',
            style: redTextStyle.copyWith(
                fontWeight: bold, fontSize: 20.sp, color: white),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                await audioPlayer.stop();
                Get.to(EditPage(
                  kataPertama: kataPertamaAnak,
                ));
              },
              icon: Icon(
                Icons.edit,
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
                    "Kenangan",
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
              SizedBox(height: 16.0.h),
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: SizedBox(
                  width: 300.w,
                  child: CustomCard(
                      title: 'Kalimat Pertama Anak',
                      subtitle: kataPertamaAnak.kataPertama,
                      iconData: FontAwesomeIcons.baby,
                      backgroundColor: red,
                      textColor: white),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Slider(
                        min: 0,
                        max: controller.duration.value.inSeconds.toDouble(),
                        value: controller.position.value.inSeconds.toDouble(),
                        onChanged: (value) async {
                          await audioPlayer
                              .seek(Duration(seconds: value.toInt()));
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(controller.position.value)),
                            Text(formatTime(controller.duration.value -
                                controller.position.value)),
                          ],
                        )),
                  ),
                  Obx(() => CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: IconButton(
                          onPressed: () async {
                            if (controller.isPlaying.value) {
                              await audioPlayer.pause();
                            } else {
                              await audioPlayer.resume();
                            }
                            controller.isPlaying.value =
                                !controller.isPlaying.value;
                          },
                          icon: Icon(
                            controller.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
