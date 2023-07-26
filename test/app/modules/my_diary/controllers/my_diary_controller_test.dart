import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Data Catatan', () {
     final jsonString = {
        "deskripsi": "deskripsi ",
        "judul": "judul ",
        "tanggal": "July 4, 2023 at 11:25:42 AM UTC+7",
        "uid": "mQSzBeHyrSbXX5J1KYeva4kLrwr1"
      };
    test('menambahkan data Catatan', () async {
      final instance = FakeFirebaseFirestore();
     
      final jsonData = jsonEncode(jsonString);
      await instance.collection('catatanku').add(jsonDecode(jsonData));
      final snapshot = await instance.collection('catatanku').get();

      expect(snapshot.docs.length, equals(1));
      expect(snapshot.docs.first.data(), equals(jsonDecode(jsonData)));
    });

    test('edit data anak', () async {
      final instance = FakeFirebaseFirestore();
      final jsonData = jsonEncode(jsonString);
      final docRef =
          await instance.collection('catatanku').add(jsonDecode(jsonData));
      final snapshot = await instance.collection('catatanku').doc(docRef.id).get();
      final updatedJsonString = {
          "deskripsi": "deskripsi baru",
        "judul": "judul baru",
        "tanggal": "July 4, 2023 at 11:25:42 AM UTC+7",
        "uid": "mQSzBeHyrSbXX5J1KYeva4kLrwr1"
      };
      final updatedJsonData = jsonEncode(updatedJsonString);
      await instance
          .collection('catatanku')
          .doc(docRef.id)
          .update(jsonDecode(updatedJsonData));
      final updatedSnapshot =
          await instance.collection('catatanku').doc(docRef.id).get();

      expect(snapshot.data(), equals(jsonDecode(jsonData)));
      expect(updatedSnapshot.data(), equals(jsonDecode(updatedJsonData)));
    });
    test('hapus data anak', () async {
      final instance = FakeFirebaseFirestore();
      final jsonData = jsonEncode(jsonString);
      final docRef =
          await instance.collection('catatanku').add(jsonDecode(jsonData));
      final snapshot = await instance.collection('catatanku').doc(docRef.id).get();
      await instance.collection('catatanku').doc(docRef.id).delete();
      final deletedSnapshot =
          await instance.collection('catatanku').doc(docRef.id).get();

      expect(snapshot.data(), equals(jsonDecode(jsonData)));
      expect(deletedSnapshot.data(), isNull);
    });
  });
}
