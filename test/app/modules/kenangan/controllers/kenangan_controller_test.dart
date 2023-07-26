import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final jsonString = {
    "caption": "gigi pertama adek 😍😍",
    "create_at": "June 7, 2023 at 12:00:00 AM UTC+7",
    "image_url":
        "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/kenangan%2F2023-07-26%2012%3A31%3A25.131280.png?alt=media&token=f86daefa-7ac0-4c3a-8a88-5b86160d529f",
    "kenanganId": "ytSX6AATO3zi178tDb8U",
    "uid": "TuVTS9kOSuPBuGDrCluwRCXxoZs2"
  };
  group('Data Kenangan:', () {
    test('menambahkan data kenangan', () async {
      final instance = FakeFirebaseFirestore();

      final jsonData = jsonEncode(jsonString);
      await instance.collection('kenangan').add(jsonDecode(jsonData));
      final snapshot = await instance.collection('kenangan').get();

      expect(snapshot.docs.length, equals(1));
      expect(snapshot.docs.first.data(), equals(jsonDecode(jsonData)));
    });

    test('edit data kenangan', () async {
      final instance = FakeFirebaseFirestore();

      final jsonData = jsonEncode(jsonString);
      final docRef =
          await instance.collection('kenangan').add(jsonDecode(jsonData));
      final snapshot =
          await instance.collection('kenangan').doc(docRef.id).get();
      final updatedJsonString = {
        "caption": "gigi pertama adek lucu 😍😍",
        "create_at": "June 7, 2023 at 12:00:00 AM UTC+7",
        "image_url":
            "https://firebasestorage.googleapis.com/v0/b/mamanote-21b82.appspot.com/o/kenangan%2F2023-07-26%2012%3A31%3A25.131280.png?alt=media&token=f86daefa-7ac0-4c3a-8a88-5b86160d529f",
        "kenanganId": docRef.id,
        "uid": "TuVTS9kOSuPBuGDrCluwRCXxoZs2"
      };

      final updatedJsonData = jsonEncode(updatedJsonString);
      await instance
          .collection('kenangan')
          .doc(docRef.id)
          .update(jsonDecode(updatedJsonData));
      final updatedSnapshot =
          await instance.collection('kenangan').doc(docRef.id).get();

      expect(snapshot.data(), equals(jsonDecode(jsonData)));
      expect(updatedSnapshot.data(), equals(jsonDecode(updatedJsonData)));

    });
  });
}
