import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/gigi_pertama_anak/controllers/add_gigi_pertama_anak.dart';
import 'package:mamanotes/app/modules/jurnal_anak/gigi_pertama_anak/controllers/gigi_pertama_anak_controller.dart';

class GigiPertamaAnakBinding extends Bindings {
  final String documentId;
  final String gigiPertamaAnakId;

  GigiPertamaAnakBinding({
    required this.documentId,
    required this.gigiPertamaAnakId,
  });
  @override
  void dependencies() {
    Get.lazyPut<GigiPertamaAnakController>(
      () => GigiPertamaAnakController(
        documentId: documentId,
        gigiAnakId: gigiPertamaAnakId,
      ),
    );
    Get.lazyPut<AddGigiPertamaAnakController>(
        () => AddGigiPertamaAnakController());
  }
}
