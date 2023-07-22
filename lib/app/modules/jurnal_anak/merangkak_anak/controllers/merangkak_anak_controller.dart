import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/merangkak_anak_model.dart';
import '../views/add_merangkak_anak_view.dart';
import '../views/merangkak_anak_view.dart';

class MerangkakAnakController extends GetxController {
  final String documentId;
  final String merangkakAnakId;

  MerangkakAnakController(
      {required this.merangkakAnakId, required this.documentId});

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('anak')
          .doc(documentId)
          .collection('jurnal_anak')
          .doc(merangkakAnakId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final kelahiranAnak = MerangkakAnakModel.fromJson(data);
        showKelahiranAnakView(kelahiranAnak);
      } else {
        debugPrint('dokumen tidak ditemukan');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  void showKelahiranAnakView(MerangkakAnakModel gigiPertamaAnakModel) =>
      Get.off(() => MerangkakAnakView(merangkakAnak: gigiPertamaAnakModel));

  void navigateToAddStimulusAnakView() =>
      Get.off(() => AddMerangkakAnakView(documentId: documentId,merangkakAnakId: merangkakAnakId));
}
