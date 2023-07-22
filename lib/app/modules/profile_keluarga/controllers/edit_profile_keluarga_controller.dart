import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamanotes/app/modules/profile_keluarga/models/profile_keluarga_model.dart';


class EditProfileKeluargaController extends GetxController {
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

  void init(Keluarga keluarga) {
    namaKeluargaController.text = keluarga.namaKeluarga;
    mottoKeluargaController.text = keluarga.mottoKeluarga;
    visiMisiController.text = keluarga.visiMisi;
    alamatRumahController.text = keluarga.alamatRumah;
    namaAyahController.text = keluarga.ayah.nama;
    namaIbuController.text = keluarga.ibu.nama;
  }

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

  Future<String> uploadFotoAnak(File fotoAnak) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_keluarga/')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageRef.putFile(fotoAnak);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Terjadi kesalahan saat mengunggah foto anak: $e');
      rethrow;
    }
  }

  Future<void> updateKeluargaData(Keluarga keluarga) async {
    final String namaKeluarga = namaKeluargaController.text;
    final String mottoKeluarga = mottoKeluargaController.text;
    final String visiMisi = visiMisiController.text;
    final String alamatRumah = alamatRumahController.text;
    final String namaAyah = namaAyahController.text;
    final String namaIbu = namaIbuController.text;

    if (!formKey.currentState!.validate()) {
      return;
    }

    final Map<String, dynamic> updatedData = {
      'namaKeluarga': namaKeluarga,
      'mottoKeluarga': mottoKeluarga,
      'visiMisi': visiMisi,
      'alamatRumah': alamatRumah,
      'ayah': {
        'nama': namaAyah,
        'foto': keluarga.ayah.foto,
      },
      'ibu': {
        'nama': namaIbu,
        'foto': keluarga.ibu.foto,
      },
    };

    if (fotoAyah.value != null && fotoAyah.value!.existsSync()) {
      final fotoAnakUrl = await uploadFotoAnak(fotoAyah.value!);
      updatedData['ayah']['foto'] = fotoAnakUrl;
    }
    if (fotoIbu.value != null && fotoIbu.value!.existsSync()) {
      final fotoAnakUrl = await uploadFotoAnak(fotoIbu.value!);
      updatedData['ibu']['foto'] = fotoAnakUrl;
    }

    try {
      await FirebaseFirestore.instance
          .collection('keluarga')
          .doc(keluarga.docId)
          .update(updatedData);
      debugPrint('Data anak berhasil diperbarui.');
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Data Keluarga berhasil diperbarui.',
        backgroundColor: Colors.transparent,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Terjadi kesalahan saat memperbarui data anak: $e');
      // Tampilkan pesan atau handling error lainnya
    }
  }
}
