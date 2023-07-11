import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/kelahiran_anak/controllers/add_jurnal_kelahiran_anak.dart';

import '../controllers/kelahiran_anak_controller.dart';

class StimulusAnakBinding extends Bindings {
  final String documentId;
  final String jurnalAnakId;

  StimulusAnakBinding({
    required this.documentId,
    required this.jurnalAnakId,
  });

  @override
  void dependencies() {
    Get.lazyPut<StimulusAnakController>(
      () => StimulusAnakController(
        documentId: documentId,
        jurnalAnakId: jurnalAnakId,
      ),
    );
    Get.lazyPut<AddStimulusAnakController>(
      () => AddStimulusAnakController(),
    );
  }
}
