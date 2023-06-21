import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

class FileInfos {
  final File file;
  final Source source;
  final DateTime validTill;
  final String originalUrl;

  FileInfos({
    required this.file,
    required this.source,
    required this.validTill,
    required this.originalUrl,
  });
}
