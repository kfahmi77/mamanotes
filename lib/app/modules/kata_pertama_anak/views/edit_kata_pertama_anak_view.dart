import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/kata_pertama_anak/models/kata_pertama_anak_model.dart';

import '../../../data/common/style.dart';

class EditPage extends StatefulWidget {
  final KataPertamaAnakModel kataPertama;

  const EditPage({super.key, required this.kataPertama});

  @override
  createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController judulController = TextEditingController();
  String? audioUrl;
  File? audioFile;

  @override
  void initState() {
    super.initState();
    judulController.text = widget.kataPertama.kataPertama;
    audioUrl = widget.kataPertama.audio;
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      audioFile = File(result.files.single.path!);
    }
  }

  Future<void> _uploadAudio() async {
    const int maxSizeInBytes = 5 * 1024 * 1024;
    if (audioFile == null || judulController.text == '') {
      Get.snackbar(
        'Error',
        'Pilih file audio dan masukkan kata pertama',
      );

      return;
    }
    if (audioFile!.lengthSync() > maxSizeInBytes) {
      Get.snackbar(
        'Error',
        'Ukuran file audio melebihi 5 MB',
      );
      return;
    }
    if (audioFile != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference audioRef = storage
          .ref()
          .child('audios')
          .child(DateTime.now().toString() + '.mp3');

      UploadTask uploadTask = audioRef.putFile(audioFile!);

      uploadTask.then((taskSnapshot) {
        taskSnapshot.ref.getDownloadURL().then((url) {
          setState(() {
            audioUrl = url;
          });
        });
      });
    }
  }

  void saveChanges() {
    var itemRef = FirebaseFirestore.instance
        .collection('anak')
        .doc(widget.kataPertama.documentId)
        .collection('jurnal_anak')
        .doc(widget.kataPertama.kataPertamaAnakId);

    itemRef.update({
      'kata_pertama': judulController.text,
      'suara': audioUrl,
    }).then((_) {
      Get.back();
      Get.back();
      Get.snackbar('Sukses', 'Perubahan berhasil disimpan');
    }).catchError((error) {
      print('Error: $error');
      // Penanganan kesalahan jika perubahan tidak berhasil disimpan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        elevation: 0,
        title: const Text('Edit Kata Pertama'),
        actions: [
          IconButton(
            onPressed: saveChanges,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: judulController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: red),
              onPressed: _pickAudio,
              child: const Text('Pilih Audio'),
            ),
            const SizedBox(height: 8.0),
            Text(
              audioFile != null
                  ? 'Audio terpilih: ${audioFile!.path}'
                  : 'silakan pilih audio jika ingin mengubah audio',
              style: const TextStyle(fontSize: 12.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: red),
              onPressed: _uploadAudio,
              child: const Text('Unggah Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
