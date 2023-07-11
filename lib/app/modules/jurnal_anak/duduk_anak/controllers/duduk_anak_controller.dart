import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/duduk_anak_model.dart';
import '../views/add_duduk_anak_view.dart';
import '../views/duduk_anak_view.dart';

class DudukAnakController extends GetxController {
  final String documentId;
  final String dudukAnakId;

  DudukAnakController(
      {required this.dudukAnakId, required this.documentId});

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('anak')
          .doc(documentId)
          .collection('jurnal_anak')
          .doc(dudukAnakId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final kelahiranAnak = DudukAnakModel.fromJson(data);
        showKelahiranAnakView(kelahiranAnak);
      } else {
        print('dokumen tidak ditemukan');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void showKelahiranAnakView(DudukAnakModel dudukAnakModel) =>
      Get.off(() => DudukAnakView(dudukAnak: dudukAnakModel));

  void navigateToAddStimulusAnakView() =>
      Get.off(() => AddDudukAnakView(documentId: documentId,dudukAnakId: dudukAnakId));
}
