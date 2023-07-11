import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/modules/my_diary/controllers/edit_diary_controller.dart';

import '../../../data/common/style.dart';

class EditDiaryView extends GetView<EditDiaryController> {
  const EditDiaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: const Text('Edit Catatan'),
        actions: [
          Obx(
            () => IconButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () => controller.editNote(Get.arguments.toString()),
              icon: const Icon(
                Icons.save_as,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: controller.getNoteById(Get.arguments.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text('Failed to get data!'),
            );
          } else {
            controller.titleC.text = snapshot.data!['judul'];
            controller.descriptionC.text = snapshot.data!['deskripsi'];

            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                TextField(
                  controller: controller.titleC,
                  autocorrect: false,
                  minLines: 1,
                  maxLines: null,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  style: formTitleTextStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Judul',
                    hintStyle: formTitleTextStyle.copyWith(
                      color: black.withOpacity(0.7),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.descriptionC,
                  autocorrect: false,
                  minLines: 1,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: formDescriptionTextStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Deskripsi',
                    hintStyle: formDescriptionTextStyle.copyWith(
                      color: lightBlackColor.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
