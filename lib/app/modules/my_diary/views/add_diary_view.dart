import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/common/style.dart';
import '../controllers/add_diary_controller.dart';

class AddDiaryView extends GetView<AddDiaryController> {
  const AddDiaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: const Text('Tambah Catatan'),
        actions: [
          Obx(
            () => IconButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () => controller.addNote(),
              icon: const Icon(
                Icons.save_as,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
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
          const SizedBox(height: 16.0),
          TextField(
            controller: controller.descriptionC,
            autocorrect: false,
            minLines: 5,
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
      ),
    );
  }
}
