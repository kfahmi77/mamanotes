import 'package:get/get.dart';

import '../controllers/profile_keluarga_controller.dart';

class ProfileKeluargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileKeluargaController>(
      () => ProfileKeluargaController(),
    );
  }
}
