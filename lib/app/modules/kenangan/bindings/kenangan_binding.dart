import 'package:get/get.dart';

import 'package:mamanotes/app/modules/kenangan/controllers/kenangan_add_controller.dart';
import 'package:mamanotes/app/modules/kenangan/controllers/kolase1_controller.dart';

import '../controllers/kenangan_controller.dart';
import '../views/kolase/kolase2_view.dart';

class KenanganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Kolase1Controller>(
      () => Kolase1Controller(),
    );
    Get.lazyPut<Kolase2Controller>(
      () => Kolase2Controller(),
    );
    Get.lazyPut<KenanganController>(
      () => KenanganController(),
    );

    Get.lazyPut<KenanganAddController>(
      () => KenanganAddController(),
    );
  }
}
