import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/bulan_pertama_anak_model.dart';
import '../views/add_bulan_pertama_anak_view.dart';
import '../views/bulan_pertama_anak_view.dart';

class BulanPertamaAnakController extends GetxController {
  final String documentId;
  final String bulanPertamaAnakId;

  BulanPertamaAnakController(
      {required this.bulanPertamaAnakId, required this.documentId});

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('anak')
          .doc(documentId)
          .collection('jurnal_anak')
          .doc(bulanPertamaAnakId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final kelahiranAnak = BulanPertamaAnakModel.fromJson(data);
        showKelahiranAnakView(kelahiranAnak);
      } else {
        debugPrint('dokumen tidak ditemukan');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  void showKelahiranAnakView(BulanPertamaAnakModel bulanPertamaAnak) =>
      Get.off(() => BulanPertamaAnakView(bulanPertamaAnak: bulanPertamaAnak));

  void navigateToAddStimulusAnakView() =>
      Get.off(() => AddBulanPertamaAnakView(documentId: documentId,bulanPertamaAnakId: bulanPertamaAnakId));
}
