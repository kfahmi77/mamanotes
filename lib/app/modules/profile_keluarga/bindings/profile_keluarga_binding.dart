import 'package:get/get.dart';

import '../controllers/add_profile_keluarga_controller.dart';
import '../controllers/profile_keluarga_controller.dart';

class ProfileKeluargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProfileKeluargaController>(
      () => AddProfileKeluargaController(),
    );
    Get.lazyPut<ProfileKeluargaController>(
      () => ProfileKeluargaController(),
    );
  }
}
