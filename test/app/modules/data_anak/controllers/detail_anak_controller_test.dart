import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Data Anak:', () {
    test('menambahkan data anak', () async {
      final instance = FakeFirebaseFirestore();
      final jsonString = {
        "arti_nama": "Anak",
        "foto_anak":
            "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/kenangan%2FSlJ5arbxEMdMVny2jUqWIwNurrY22023-07-21%2005%3A33%3A52.515627.jpg?alt=media&token=8a80f433-9342-4149-afcf-1d0e2a562415",
        "golongan_darah": "0",
        "jenis_kelamin": "laki-laki",
        "nama_lengkap": "Anak",
        "nama_panggilan": "A",
        "tanggal_lahir": "July 21, 2023 at 5:33:52 AM UTC+7",
        "tempat": "Bandung",
        "uid": "SlJ5arbxEMdMVny2jUqWIwNurrY2"
      };
      final jsonData = jsonEncode(jsonString);
      await instance.collection('anak').add(jsonDecode(jsonData));
      final snapshot = await instance.collection('anak').get();

      expect(snapshot.docs.length, equals(1));
      expect(snapshot.docs.first.data(), equals(jsonDecode(jsonData)));
    });

    test('edit data anak', () async {
  final instance = FakeFirebaseFirestore();
  final jsonString = {
    "arti_nama": "Anak",
    "foto_anak":
        "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/kenangan%2FSlJ5arbxEMdMVny2jUqWIwNurrY22023-07-21%2005%3A33%3A52.515627.jpg?alt=media&token=8a80f433-9342-4149-afcf-1d0e2a562415",
    "golongan_darah": "0",
    "jenis_kelamin": "laki-laki",
    "nama_lengkap": "Anak",
    "nama_panggilan": "A",
    "tanggal_lahir": "July 21, 2023 at 5:33:52 AM UTC+7",
    "tempat": "Bandung",
    "uid": "SlJ5arbxEMdMVny2jUqWIwNurrY2"
  };
  final jsonData = jsonEncode(jsonString);
  final docRef = await instance.collection('anak').add(jsonDecode(jsonData));
  final snapshot = await instance.collection('anak').doc(docRef.id).get();
  final updatedJsonString = {
    "arti_nama": "Anak Baru",
    "foto_anak":
        "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/kenangan%2FSlJ5arbxEMdMVny2jUqWIwNurrY22023-07-21%2005%3A33%3A52.515627.jpg?alt=media&token=8a80f433-9342-4149-afcf-1d0e2a562415",
    "golongan_darah": "0",
    "jenis_kelamin": "laki-laki",
    "nama_lengkap": "Anak Baru",
    "nama_panggilan": "AB",
    "tanggal_lahir": "July 21, 2023 at 5:33:52 AM UTC+7",
    "tempat": "Jakarta",
    "uid": "SlJ5arbxEMdMVny2jUqWIwNurrY2"
  };
  final updatedJsonData = jsonEncode(updatedJsonString);
  await instance.collection('anak').doc(docRef.id).update(jsonDecode(updatedJsonData));
  final updatedSnapshot = await instance.collection('anak').doc(docRef.id).get();

  expect(snapshot.data(), equals(jsonDecode(jsonData)));
  expect(updatedSnapshot.data(), equals(jsonDecode(updatedJsonData)));
});
    
  });
}
