import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/tahun_pertama_anak_model.dart';
import '../views/add_tahun_pertama_anak_view.dart';
import '../views/tahun_pertama_anak_view.dart';

class TahunPertamaAnakController extends GetxController {
  final String documentId;
  final String tahunPertamaAnakId;

  TahunPertamaAnakController(
      {required this.tahunPertamaAnakId, required this.documentId});

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('anak')
          .doc(documentId)
          .collection('jurnal_anak')
          .doc(tahunPertamaAnakId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final kelahiranAnak = TahunPertamaAnakModel.fromJson(data);
        showKelahiranAnakView(kelahiranAnak);
      } else {
        print('dokumen tidak ditemukan');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void showKelahiranAnakView(TahunPertamaAnakModel tahunPertamaAnak) =>
      Get.off(() => TahunPertamaAnakView(tahunPertamaAnak: tahunPertamaAnak));

  void navigateToAddStimulusAnakView() =>
      Get.off(() => AddTahunPertamaAnakView(documentId: documentId,tahunPertamaAnakId: tahunPertamaAnakId));
}
