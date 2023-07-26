import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> getJurnalAnakDocument(String anakId,jurnalAnakId) async {
  return await FirebaseFirestore.instance
      .collection('anak')
      .doc(anakId)
      .collection('jurnal_anak')
      .doc(jurnalAnakId)
      .get();
}
