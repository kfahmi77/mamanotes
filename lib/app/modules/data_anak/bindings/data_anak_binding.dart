import 'package:get/get.dart';
import 'package:mamanotes/app/modules/data_anak/controllers/detail_anak_controller.dart';

import '../controllers/data_anak_controller.dart';

class DataAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataAnakController>(
      () => DataAnakController(),
    );
    Get.lazyPut<DetailAnakController>(() => DetailAnakController());
  }
}
