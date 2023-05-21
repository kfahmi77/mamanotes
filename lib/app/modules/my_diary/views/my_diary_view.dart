import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/common/style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/my_diary_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyDiaryView extends GetView<MyDiaryController> {
  const MyDiaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatanku'),
        backgroundColor: red,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
            return const Center(
              child: Text('Data Kosong'),
            );
          }

          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: snapshot.data!.docs.length,
            padding: const EdgeInsets.all(22),
            itemBuilder: (context, index) {
              final docNote = snapshot.data!.docs[index];
              final note = docNote.data();

              DateTime date =
                  DateTime.parse(note['tanggal'].toDate().toString());
              debugPrint(docNote.id);

              return Material(
                color: cardDiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () => Get.toNamed(
                    Routes.editDiary,
                    arguments: docNote.id,
                  ),
                  onLongPress: () => controller.deleteNote(docNote.id),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${note['judul']}',
                          style: robottoBlackTextStyle.copyWith(
                              fontSize: 16.sp, fontWeight: semiBold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${note['deskripsi']}',
                          style: robottoBlackTextStyle.copyWith(
                              fontSize: 15.sp, fontWeight: normal),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          DateFormat('dd-MMM-yyy', 'id_ID').format(date),
                          style: robottoBlackTextStyle.copyWith(
                              fontSize: 15.sp, fontWeight: normal),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: red,
        onPressed: () {
          Get.toNamed(Routes.addDiary);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
