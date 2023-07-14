import 'package:get/get.dart';

import '../controllers/add_tahun_pertama_anak_controller.dart';
import '../controllers/tahun_pertama_anak_controller.dart';

class TahunPertamaAnakBinding extends Bindings {
  final String documentId;
  final String tahunPertamaAnakId;

  TahunPertamaAnakBinding({
    required this.documentId,
    required this.tahunPertamaAnakId,
  });
  @override
  void dependencies() {
    Get.lazyPut<TahunPertamaAnakController>(
      () => TahunPertamaAnakController(
        documentId: documentId,
        tahunPertamaAnakId: tahunPertamaAnakId,
      ),
    );
    Get.lazyPut<AddTahunPertamaAnakController>(
        () => AddTahunPertamaAnakController());
  }
}
