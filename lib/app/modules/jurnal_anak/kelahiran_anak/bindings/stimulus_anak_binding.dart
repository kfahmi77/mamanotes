import 'package:get/get.dart';

import '../controllers/kelahiran_anak_controller.dart';

class StimulusAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StimulusAnakController>(
      () => StimulusAnakController(),
    );
  }
}
