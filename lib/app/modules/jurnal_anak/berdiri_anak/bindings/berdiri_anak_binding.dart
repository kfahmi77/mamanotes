import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/berdiri_anak/controllers/berdiri_anak_controller.dart';

import '../controllers/add_berdiri_anak_controller.dart';

class BerdiriAnakBinding extends Bindings {
  final String documentId;
  final String berdiriAnakId;

  BerdiriAnakBinding({
    required this.documentId,
    required this.berdiriAnakId,
  });
  @override
  void dependencies() {
    Get.lazyPut<BerdiriAnakController>(
      () => BerdiriAnakController(
        documentId: documentId,
        berdiriAnakId: berdiriAnakId,
      ),
    );
    Get.lazyPut<AddBerdiriAnakController>(() => AddBerdiriAnakController());
  }
}
