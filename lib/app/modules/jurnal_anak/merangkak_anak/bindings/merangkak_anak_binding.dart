import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/merangkak_anak/controllers/merangkak_anak_controller.dart';

import '../controllers/add_merangkak_anak_controller.dart';

class MerangkakAnakBinding extends Bindings {
  final String documentId;
  final String merangkakAnakId;

  MerangkakAnakBinding({
    required this.documentId,
    required this.merangkakAnakId,
  });
  @override
  void dependencies() {
    Get.lazyPut<MerangkakAnakController>(
      () => MerangkakAnakController(
        documentId: documentId,
        merangkakAnakId: merangkakAnakId,
      ),
    );
    Get.lazyPut<AddMerangkakAnakController>(() => AddMerangkakAnakController());
  }
}
