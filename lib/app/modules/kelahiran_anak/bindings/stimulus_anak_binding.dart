import 'package:get/get.dart';

import '../controllers/stimulus_anak_controller.dart';

class StimulusAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StimulusAnakController>(
      () => StimulusAnakController(),
    );
  }
}
