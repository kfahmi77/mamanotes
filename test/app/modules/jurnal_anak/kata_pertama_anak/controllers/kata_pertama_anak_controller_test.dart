import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  final jsonData = {
    "documentId": "sLvhhMbwzY1iYTcRAHEF",
    "kataPertamaId": "kataAnakPertamasLvhhMbwzY1iYTcRAHEF",
    "kata_pertama": "ibu",
    "suara":
        "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/jurnal_anak%2Fkata_pertama%2F1690346002194.mp3?alt=media&token=8ae19626-1a35-4e29-b896-862c501e45db"
  };

  group('Data Kata Pertama Anak  :', () {
    test('menambahkan data kata pertama anak', () async {
      final instance = FakeFirebaseFirestore();

      final parentDocumentRef =
          instance.collection('anak').doc(jsonData['anakId']);

      final childDocumentRef = parentDocumentRef
          .collection('jurnal_anak')
          .doc(jsonData['kataPertamaAnakId']);

      await childDocumentRef.set(jsonData);

      final snapshot = await childDocumentRef.get();

      expect(snapshot.exists, equals(true));
      expect(snapshot.data(), equals(jsonData));
      
    });

    test('update data kata pertama anak', () async {
      final instance = FakeFirebaseFirestore();

      final parentDocumentRef =
          instance.collection('anak').doc(jsonData['anakId']);

      final childDocumentRef = parentDocumentRef
          .collection('jurnal_anak')
          .doc(jsonData['kataPertamaAnakId']);

      await childDocumentRef.set(jsonData);

      jsonData['suara'] = 'suara baru test';

      await childDocumentRef.update(jsonData);

      final snapshot = await childDocumentRef.get();

      expect(snapshot.exists, equals(true));
      expect(snapshot.data(), equals(jsonData));
      print(snapshot.data());
    });
  });
}
