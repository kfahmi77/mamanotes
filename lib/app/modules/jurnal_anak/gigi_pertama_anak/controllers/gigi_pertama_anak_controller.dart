import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/gigi_pertama_anak/models/gigi_pertama_anak_model.dart';

import '../views/add_gigi_pertama_anak.dart';
import '../views/gigi_pertama_anak_view.dart';

class GigiPertamaAnakController extends GetxController {
  final String documentId;
  final String gigiAnakId;

  GigiPertamaAnakController(
      {required this.gigiAnakId, required this.documentId});

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('anak')
          .doc(documentId)
          .collection('jurnal_anak')
          .doc(gigiAnakId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final kelahiranAnak = GigiPertamaAnakModel.fromJson(data);
        showKelahiranAnakView(kelahiranAnak);
      } else {
        print('dokumen tidak ditemukan');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void showKelahiranAnakView(GigiPertamaAnakModel gigiPertamaAnakModel) =>
      Get.off(() => GigiPertamaAnakView(gigiAnak: gigiPertamaAnakModel));

  void navigateToAddStimulusAnakView() =>
      Get.off(() => AddGigiPertamaAnakView(documentId: documentId,gigiAnakId: gigiAnakId));
}
