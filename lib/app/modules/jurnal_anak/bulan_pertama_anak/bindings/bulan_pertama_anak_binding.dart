import 'package:get/get.dart';

import '../controllers/add_bulan_pertama_anak_controller.dart';
import '../controllers/bulan_pertama_anak_controller.dart';

class BulanPertamaAnakBinding extends Bindings {
  final String documentId;
  final String bulanPertamaAnakId;

  BulanPertamaAnakBinding({
    required this.documentId,
    required this.bulanPertamaAnakId,
  });
  @override
  void dependencies() {
    Get.lazyPut<BulanPertamaAnakController>(
      () => BulanPertamaAnakController(
        documentId: documentId,
        bulanPertamaAnakId: bulanPertamaAnakId,
      ),
    );
    Get.lazyPut<AddBulanPertamaAnakController>(
        () => AddBulanPertamaAnakController());
  }
}
