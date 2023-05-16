import 'package:get/get.dart';

import 'package:mamanotes/app/modules/my_diary/controllers/add_diary_controller.dart';
import 'package:mamanotes/app/modules/my_diary/controllers/edit_diary_controller.dart';

import '../controllers/my_diary_controller.dart';

class MyDiaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditDiaryController>(
      () => EditDiaryController(),
    );
    Get.lazyPut<AddDiaryController>(
      () => AddDiaryController(),
    );
    Get.lazyPut<MyDiaryController>(
      () => MyDiaryController(),
    );
  }
}
