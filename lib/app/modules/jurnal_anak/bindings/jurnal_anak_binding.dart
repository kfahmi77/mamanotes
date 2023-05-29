import 'package:get/get.dart';
import 'package:mamanotes/app/modules/data_anak/controllers/detail_anak_controller.dart';

import '../controllers/jurnal_anak_controller.dart';

class JurnalAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JurnalAnakController>(
      () => JurnalAnakController(),
    );
     Get.lazyPut<DetailAnakController>(
      () => DetailAnakController(),
    );
  }
}
