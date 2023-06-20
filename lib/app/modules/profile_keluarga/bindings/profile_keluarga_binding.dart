import 'package:get/get.dart';

import 'package:mamanotes/app/modules/profile_keluarga/controllers/edit_profile_keluarga_controller.dart';

import '../controllers/add_profile_keluarga_controller.dart';
import '../controllers/profile_keluarga_controller.dart';

class ProfileKeluargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileKeluargaController>(
      () => EditProfileKeluargaController(),
    );
    Get.lazyPut<AddProfileKeluargaController>(
      () => AddProfileKeluargaController(),
    );
    Get.lazyPut<ProfileKeluargaController>(
      () => ProfileKeluargaController(),
    );
  }
}
