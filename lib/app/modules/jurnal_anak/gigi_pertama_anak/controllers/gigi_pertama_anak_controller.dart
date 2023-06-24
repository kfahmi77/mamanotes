import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/gigi_pertama_anak/models/gigi_pertama_anak_model.dart';

class GigiPertamaAnakController extends GetxController {
  final CollectionReference imagesCollection =
      FirebaseFirestore.instance.collection('images');

  Stream<List<GigiPertamaAnakModel>> get imagesStream =>
      imagesCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            final imageUrl = data['imageUrl'] ?? '';
            return GigiPertamaAnakModel(imageUrl);
          }).toList());

  @override
  void onInit() {
    super.onInit();
  }
}