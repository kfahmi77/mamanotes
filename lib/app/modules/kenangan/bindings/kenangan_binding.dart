import 'package:get/get.dart';
import 'package:mamanotes/app/modules/kenangan/controllers/kenangan_add_controller.dart';

import '../controllers/kenangan_controller.dart';

class KenanganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KenanganController>(
      () => KenanganController(),
    );
    Get.lazyPut<KenanganAddController>(
      () => KenanganAddController(),
    );
  }
}
