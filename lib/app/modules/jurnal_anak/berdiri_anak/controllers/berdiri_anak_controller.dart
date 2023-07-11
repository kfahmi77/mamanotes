import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/berdiri_anak_model.dart';
import '../views/add_berdiri_anak_view.dart';
import '../views/berdiri_anak_view.dart';

class BerdiriAnakController extends GetxController {
  final String documentId;
  final String berdiriAnakId;

  BerdiriAnakController(
      {required this.berdiriAnakId, required this.documentId});

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('anak')
          .doc(documentId)
          .collection('jurnal_anak')
          .doc(berdiriAnakId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final kelahiranAnak = BerdiriAnakModel.fromJson(data);
        showKelahiranAnakView(kelahiranAnak);
      } else {
        print('dokumen tidak ditemukan');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void showKelahiranAnakView(BerdiriAnakModel gigiPertamaAnakModel) =>
      Get.off(() => BerdiriAnakView(berdiriAnak: gigiPertamaAnakModel));

  void navigateToAddStimulusAnakView() =>
      Get.off(() => AddBerdiriAnakView(documentId: documentId,berdiriAnakId: berdiriAnakId));
}
