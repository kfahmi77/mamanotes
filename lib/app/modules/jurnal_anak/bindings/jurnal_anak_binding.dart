import 'package:get/get.dart';

import '../controllers/jurnal_anak_controller.dart';

class JurnalAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JurnalAnakController>(
      () => JurnalAnakController(),
    );
  }
}
