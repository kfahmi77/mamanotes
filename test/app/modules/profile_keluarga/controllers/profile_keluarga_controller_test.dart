import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final jsonString = {
    "alamatRumah": "okelah",
    "ayah": {
      "foto":
          "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/profil_keluarga%2F1687144155584.jpg?alt=media&token=1f5992ef-bc62-40aa-820b-7ee416bf6919",
      "nama": "ardi"
    },
    "documentId": "FWz9P7wGQituQe5iJhWE",
    "ibu": {
      "foto":
          "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/profile_keluarga%2F1688791901888.jpg?alt=media&token=1b1e39bd-d217-4924-891d-60e8c831e97b",
      "nama": "meli"
    },
    "mottoKeluarga": "ok",
    "namaKeluarga": "joss",
    "uid": "mQSzBeHyrSbXX5J1KYeva4kLrwr1",
    "visiMisi": "oke banget"
  };

 group('Data Profile keluarga:', () {
    test('menambahkan data profile keluarga', () async {
      final instance = FakeFirebaseFirestore();
      
      final jsonData = jsonEncode(jsonString);
      await instance.collection('keluarga').add(jsonDecode(jsonData));
      final snapshot = await instance.collection('keluarga').get();

      expect(snapshot.docs.length, equals(1));
      expect(snapshot.docs.first.data(), equals(jsonDecode(jsonData)));
    });

    test('edit data profile keluarga', () async {
  final instance = FakeFirebaseFirestore();
  
  final jsonData = jsonEncode(jsonString);
  final docRef = await instance.collection('keluarga').add(jsonDecode(jsonData));
  final snapshot = await instance.collection('keluarga').doc(docRef.id).get();
  final updatedJsonString = {
    "alamatRumah": "test",
    "ayah": {
      "foto":
          "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/profil_keluarga%2F1687144155584.jpg?alt=media&token=1f5992ef-bc62-40aa-820b-7ee416bf6919",
      "nama": "ardi"
    },
    "documentId": "FWz9P7wGQituQe5iJhWE",
    "ibu": {
      "foto":
          "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/profile_keluarga%2F1688791901888.jpg?alt=media&token=1b1e39bd-d217-4924-891d-60e8c831e97b",
      "nama": "meli"
    },
    "mottoKeluarga": "ok",
    "namaKeluarga": "joss",
    "uid": "mQSzBeHyrSbXX5J1KYeva4kLrwr1",
    "visiMisi": "oke banget"
  };
  final updatedJsonData = jsonEncode(updatedJsonString);
  await instance.collection('keluarga').doc(docRef.id).update(jsonDecode(updatedJsonData));
  final updatedSnapshot = await instance.collection('keluarga').doc(docRef.id).get();

  expect(snapshot.data(), equals(jsonDecode(jsonData)));
  expect(updatedSnapshot.data(), equals(jsonDecode(updatedJsonData)));
});
    
  });
}
