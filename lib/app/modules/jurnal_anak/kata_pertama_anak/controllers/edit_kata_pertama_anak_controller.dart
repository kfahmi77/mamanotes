import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditKataPertamaAnakController extends GetxController {
  final TextEditingController judulController = TextEditingController();
  Rx<File?> audioFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    judulController.text = Get.arguments.kataPertama.kataPertama;
    audioFile.value = File(Get.arguments.kataPertama.audio);
  }

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      audioFile.value = File(result.files.single.path!);
    }
  }

  Future<void> uploadAudio() async {
    const int maxSizeInBytes = 5 * 1024 * 1024;
    if (audioFile.value == null || judulController.text == '') {
      Get.snackbar(
        'Error',
        'Pilih file audio dan masukkan kata pertama',
      );

      return;
    }
    if (audioFile.value!.lengthSync() > maxSizeInBytes) {
      Get.snackbar(
        'Error',
        'Ukuran file audio melebihi 5 MB',
      );
      return;
    }
    if (audioFile.value != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference audioRef =
          storage.ref().child('audios').child('${DateTime.now()}.mp3');

      UploadTask uploadTask = audioRef.putFile(audioFile.value!);

      uploadTask.then((taskSnapshot) {
        taskSnapshot.ref.getDownloadURL().then((url) {
          audioFile.value = url as File?;
        });
      });
    }
  }

  void saveChanges() {
    var itemRef = FirebaseFirestore.instance
        .collection('anak')
        .doc(Get.arguments.kataPertama.documentId)
        .collection('jurnal_anak')
        .doc(Get.arguments.kataPertama.kataPertamaAnakId);

    itemRef.update({
      'kata_pertama': judulController.text,
      'suara': audioFile.value?.toString(),
    }).then((_) {
      Get.back();
      Get.back();
      Get.snackbar('Sukses', 'Perubahan berhasil disimpan');
    }).catchError((error) {
      debugPrint('Error: $error');
      // Penanganan kesalahan jika perubahan tidak berhasil disimpan
    });
  }
}
