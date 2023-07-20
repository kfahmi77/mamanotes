import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/kata_pertama_anak/views/kata_pertama_anak_view.dart';

import '../models/kata_pertama_anak_model.dart';

class KataPertamaAnakController extends GetxController {
  final String documentId;
  final String kataPertamaAnakId;
  final audioPlayer = AudioPlayer().obs;
  final isPlaying = false.obs;
  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;
  final disposed = false.obs;

  KataPertamaAnakController({
    required this.kataPertamaAnakId,
    required this.documentId,
  });

  @override
  void onInit() {
    super.onInit();
    fetchData();
    audioPlayer.value.onPlayerStateChanged.listen((playerState) {
      isPlaying.value = playerState == PlayerState.playing;
    });
    audioPlayer.value.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });
    audioPlayer.value.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });
  }

  Future<void> setAudio(String url) async {
    audioPlayer.value.setReleaseMode(ReleaseMode.loop);

    FileInfo? fileInfo = await DefaultCacheManager().getFileFromCache(url);

    if (fileInfo != null && fileInfo.file.existsSync()) {
      // File audio ditemukan di cache lokal, mainkan dari cache
      File cachedFile = fileInfo.file;
      await audioPlayer.value.play(UrlSource(cachedFile.path));
      isPlaying.value = true;
    } else {
      // File tidak ditemukan di cache, download dan simpan di cache
      try {
        DefaultCacheManager cacheManager = DefaultCacheManager();
        File cachedFile = await cacheManager.getSingleFile(url, key: url);
        await audioPlayer.value.play(UrlSource(cachedFile.path));
        isPlaying.value = true;
      } catch (e) {
        // Gagal mendownload file
        isPlaying.value = false;
        print("Gagal mendownload file: $e");
      }
    }
  }

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('anak')
          .doc(documentId)
          .collection('jurnal_anak')
          .doc(kataPertamaAnakId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        setAudio(data['suara']);
        final kataPertamaAnak = KataPertamaAnakModel.fromJson(data);
        showKelahiranAnakView(kataPertamaAnak);
      } else {
        print('dokumen tidak ditemukan');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void showKelahiranAnakView(KataPertamaAnakModel kataPertamaAnak) =>
      Get.off(() => KataPertamaAnakView(kataPertamaAnak: kataPertamaAnak));
}
