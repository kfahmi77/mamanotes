import 'package:get/get.dart';

import '../controllers/kata_pertama_anak_controller.dart';

class KataPertamaAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KataPertamaAnakController>(
      () => KataPertamaAnakController(),
    );
  }
}
