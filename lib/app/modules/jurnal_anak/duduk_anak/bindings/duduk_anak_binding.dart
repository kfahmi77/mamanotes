import 'package:get/get.dart';

import '../controllers/add_duduk_anak_controller.dart';
import '../controllers/duduk_anak_controller.dart';

class DudukAnakBinding extends Bindings {
  final String documentId;
  final String dudukAnakId;

  DudukAnakBinding({
    required this.documentId,
    required this.dudukAnakId,
  });
  @override
  void dependencies() {
    Get.lazyPut<DudukAnakController>(
      () => DudukAnakController(
        documentId: documentId,
        dudukAnakId: dudukAnakId,
      ),
    );
    Get.lazyPut<AddDudukAnakController>(() => AddDudukAnakController());
  }
}
