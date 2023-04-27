import 'package:get/get.dart';

import '../controllers/kenangan_controller.dart';

class KenanganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KenanganController>(
      () => KenanganController(),
    );
  }
}
