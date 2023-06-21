import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class KataPertamaAnakView extends StatefulWidget {
  const KataPertamaAnakView({super.key});

  @override
  createState() => _KataPertamaAnakViewState();
}

class _KataPertamaAnakViewState extends State<KataPertamaAnakView> {
  String? audioUrl;
  AudioPlayer audioPlayer = AudioPlayer();

  Future<String> pickAndUploadAudioToFirebaseStorage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      File file = File(result.files.single.path!);
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('audio');
      final UploadTask uploadTask = storageRef
          .child(DateTime.now().millisecondsSinceEpoch.toString() + '.aac')
          .putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      throw 'No file selected';
    }
  }

  void playAudioFromUrlWithCaching(String audioUrl) async {
    final cacheManager = DefaultCacheManager();
    FileInfo? fileInfo = await cacheManager.getFileFromCache(audioUrl);

    if (fileInfo == null) {
      File fetchedFile = await cacheManager.getSingleFile(audioUrl);
      fileInfo = (await cacheManager.putFile(
        audioUrl,
        (await fetchedFile.readAsBytes()) as Uint8List,
        key: audioUrl,
      )) as FileInfo?;
    }

    audioPlayer.setSourceUrl(audioUrl);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (audioUrl != null) ...[
              PlayerControls(audioPlayer: audioPlayer),
              SizedBox(height: 20),
              Text('Audio URL: $audioUrl'),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final downloadUrl =
                      await pickAndUploadAudioToFirebaseStorage();
                  setState(() {
                    audioUrl = downloadUrl;
                  });
                  playAudioFromUrlWithCaching(downloadUrl);
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: Text('Upload and Play Audio'),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerControls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const PlayerControls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () => audioPlayer.resume(),
        ),
        IconButton(
          icon: Icon(Icons.pause),
          onPressed: () => audioPlayer.pause(),
        ),
        IconButton(
          icon: Icon(Icons.stop),
          onPressed: () => audioPlayer.stop(),
        ),
      ],
    );
  }
}
