import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/kelahiran_anak/bindings/stimulus_anak_binding.dart';

import '../models/kelahiran_anak_model.dart';
import '../views/add_jurnal_kelahiran_anak_view.dart';
import '../views/stimulus_anak_view.dart';

class StimulusAnakController extends GetxController {
  final String documentId;
  final String jurnalAnakId;

  StimulusAnakController(
      {required this.jurnalAnakId, required this.documentId});

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('anak')
          .doc(documentId)
          .collection('jurnal_anak')
          .doc(jurnalAnakId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final kelahiranAnak = KelahiranAnak.fromJson(data);
        showKelahiranAnakView(kelahiranAnak);
      } else {
        print('dokumen tidak ditemukan');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void showKelahiranAnakView(KelahiranAnak kelahiranAnak) =>
      Get.off(() => KelahiranAnakView(kelahiranAnak: kelahiranAnak));

  void navigateToAddStimulusAnakView() => Get.off(
      () => AddKelahiranAnakView(
          kelahiranAnakId: jurnalAnakId, anakId: documentId),
      binding: StimulusAnakBinding(
          documentId: documentId, jurnalAnakId: jurnalAnakId));
}
