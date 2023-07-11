import 'package:get/get.dart';

import 'package:mamanotes/app/modules/kenangan/controllers/kenangan_add_controller.dart';
import 'package:mamanotes/app/modules/kenangan/controllers/kolase1_controller.dart';
import 'package:mamanotes/app/modules/kenangan/controllers/kolase3_controller.dart';
import 'package:mamanotes/app/modules/kenangan/controllers/kolase4_controller.dart';
import 'package:mamanotes/app/modules/kenangan/controllers/kolase5_controller.dart';

import '../controllers/kenangan_controller.dart';
import '../controllers/kolase2_controller.dart';
import '../views/kolase/kolase2_view.dart';

class KenanganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Kolase5Controller>(
      () => Kolase5Controller(),
    );
    Get.lazyPut<Kolase4Controller>(
      () => Kolase4Controller(),
    );
    Get.lazyPut<Kolase3Controller>(
      () => Kolase3Controller(),
    );
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
