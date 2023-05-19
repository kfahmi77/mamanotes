import 'package:get/get.dart';

import '../controllers/data_anak_controller.dart';

class DataAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataAnakController>(
      () => DataAnakController(),
    );
  }
}
