import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  final jsonData = {
    "anakId": "cWukmmIEHvvoPYlt0yna",
    "beratAnakLahir": 4.4,
    "doaAyah": "amin",
    "doaIbu": "amin",
    "kelahiranAnakId": "kelahiranAnakcWukmmIEHvvoPYlt0yna",
    "petugasKesehatan": "dokter rian",
    "tempatLahir": "okelahaa",
    "tinggiAnakLahir": 16,
    "urlFotoAnak": "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/birth_photos%2FIMG_20230720_103546.jpg?alt=media&token=c7469701-64bf-4001-9396-1fb797ebb537",
    "urlFotoCapKaki": "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/footprint_photos%2FIMG_20230618_174355.jpg?alt=media&token=ccc3f481-0fac-4a2b-b69d-5002b0b8eed6",
    "urlFotoKelahiran": "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/delivery_photos%2FIMG_20230618_174355.jpg?alt=media&token=8f4fb716-c92e-4be6-91cd-0fb3f985a6ae",
    "waktuLahir": "20:46",
  };

  group('Data Anak kelahiran :', () {
    test('menambahkan data anak', () async {
      final instance = FakeFirebaseFirestore();

      final parentDocumentRef =
            instance.collection('anak').doc(jsonData['anakId'] as String);

      final childDocumentRef = parentDocumentRef
          .collection('jurnal_anak')
          .doc(jsonData['kelahiranAnakId'] as String?);

      await childDocumentRef.set(jsonData);

      final snapshot = await childDocumentRef.get();

      expect(snapshot.exists, equals(true));
      expect(snapshot.data(), equals(jsonData));
    });

    test('update data anak', () async {
      final instance = FakeFirebaseFirestore();

      final parentDocumentRef =
          instance.collection('anak').doc(jsonData['anakId'] as String?);

      final childDocumentRef = parentDocumentRef
          .collection('jurnal_anak')
          .doc(jsonData['kelahiranAnakId'] as String?);

      await childDocumentRef.set(jsonData);

      jsonData['beratAnakLahir'] = 4.0;

      await childDocumentRef.update(jsonData);

      final snapshot = await childDocumentRef.get();

      expect(snapshot.exists, equals(true));
      expect(snapshot.data(), equals(jsonData));
      
    });
  });
}
