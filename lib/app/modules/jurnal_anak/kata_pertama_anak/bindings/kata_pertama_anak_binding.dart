import 'package:get/get.dart';

import 'package:mamanotes/app/modules/jurnal_anak/kata_pertama_anak/controllers/add_kata_pertama_anak_controller.dart';
import 'package:mamanotes/app/modules/jurnal_anak/kata_pertama_anak/controllers/edit_kata_pertama_anak_controller.dart';

import '../controllers/kata_pertama_anak_controller.dart';

class KataPertamaAnakBinding extends Bindings {
  final String documentId;
  final String kataPertamaAnakId;

  KataPertamaAnakBinding({
    required this.documentId,
    required this.kataPertamaAnakId,
  });
  @override
  void dependencies() {
    Get.lazyPut<EditKataPertamaAnakController>(
      () => EditKataPertamaAnakController(),
    );
    Get.lazyPut<AddKataPertamaAnakController>(
      () => AddKataPertamaAnakController(),
    );
    Get.lazyPut<KataPertamaAnakController>(
      () => KataPertamaAnakController(
          documentId: documentId, kataPertamaAnakId: kataPertamaAnakId),
    );
  }
}
