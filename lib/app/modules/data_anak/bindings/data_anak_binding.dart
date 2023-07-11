import 'package:get/get.dart';

import 'package:mamanotes/app/modules/data_anak/controllers/detail_anak_controller.dart';
import 'package:mamanotes/app/modules/data_anak/controllers/edit_data_anak_controller.dart';

import '../controllers/tambah_data_anak_controller.dart';

class DataAnakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditDataAnakController>(
      () => EditDataAnakController(),
    );
    Get.lazyPut<TambahDataAnakController>(
      () => TambahDataAnakController(),
    );
    Get.lazyPut<DetailAnakController>(() => DetailAnakController());
  }
}
