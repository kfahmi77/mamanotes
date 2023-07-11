import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../dashboard/views/dashboard_view.dart';
import '../models/profile_keluarga_model.dart';

class AddProfileKeluargaController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController namaKeluargaController = TextEditingController();
  final TextEditingController mottoKeluargaController = TextEditingController();
  final TextEditingController visiMisiController = TextEditingController();
  final TextEditingController alamatRumahController = TextEditingController();
  final TextEditingController namaAyahController = TextEditingController();
  final TextEditingController namaIbuController = TextEditingController();
  final fotoAyah = Rx<File?>(null);
  final fotoIbu = Rx<File?>(null);
  final picker = ImagePicker();

  Future<void> pickFoto(ImageSource source, Rx<File?> foto) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      foto.value = File(pickedImage.path);
    }
  }

  Future<void> pickFotoAyah() async {
    await pickFoto(ImageSource.gallery, fotoAyah);
  }

  Future<void> pickFotoIbu() async {
    await pickFoto(ImageSource.gallery, fotoIbu);
  }

  Future<String> uploadFoto(String path) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('foto_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(File(path));
    return ref.getDownloadURL();
  }

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      final ayahFotoUrl =
          fotoAyah.value != null ? await uploadFoto(fotoAyah.value!.path) : '';
      final ibuFotoUrl =
          fotoIbu.value != null ? await uploadFoto(fotoIbu.value!.path) : '';

      final keluarga = Keluarga(
        uid: '',
        docId: '',
        namaKeluarga: namaKeluargaController.text,
        mottoKeluarga: mottoKeluargaController.text,
        visiMisi: visiMisiController.text,
        alamatRumah: alamatRumahController.text,
        ayah: Ayah(
          nama: namaAyahController.text,
          foto: ayahFotoUrl,
        ),
        ibu: Ibu(
          nama: namaIbuController.text,
          foto: ibuFotoUrl,
        ),
      );

      final docRef = await FirebaseFirestore.instance
          .collection('keluarga')
          .add(keluarga.toJson());
      final docId = docRef.id;
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await docRef.update({'uid': uid, 'documentId': docId});
      Get.offAll(() => const DashboardView());
      Get.snackbar("Berhasil", "Data Keluarga berhasil ditambahkan");
    }
  }
}
