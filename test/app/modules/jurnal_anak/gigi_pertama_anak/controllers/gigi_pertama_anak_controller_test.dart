import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  final jsonData = {
    "gigiPertamaId": "gigiPertamaAnaksLvhhMbwzY1iYTcRAHEF",
    "documentId": "3ACWKSnbo4NFg7BH2vcL",
    "foto_gigi_anak":
        "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/1689892818104?alt=media&token=c000a58b-e5a0-4847-a81c-9a50a1070ffa",
  };
  group('Data Gigi Pertama Anak  :', () {
    test('menambahkan data gigi pertama anak', () async {
      final instance = FakeFirebaseFirestore();

      final parentDocumentRef =
          instance.collection('anak').doc(jsonData['documentId']);

      final childDocumentRef = parentDocumentRef
          .collection('jurnal_anak')
          .doc(jsonData['gigiPertamaId']);

      await childDocumentRef.set(jsonData);

      final snapshot = await childDocumentRef.get();

      expect(snapshot.exists, equals(true));
      expect(snapshot.data(), equals(jsonData));
    });
    test('update data gigi pertama anak', () async {
      final instance = FakeFirebaseFirestore();

      final parentDocumentRef =
          instance.collection('anak').doc(jsonData['documentId']);

      final childDocumentRef = parentDocumentRef
          .collection('jurnal_anak')
          .doc(jsonData['gigiPertamaId']);
      await childDocumentRef.set(jsonData);

      jsonData['foto_gigi_anak'] = 'url baru';

      await childDocumentRef.update(jsonData);

      final snapshot = await childDocumentRef.get();

      expect(snapshot.exists, equals(true));
      expect(snapshot.data(), equals(jsonData));
    });
  });
}
