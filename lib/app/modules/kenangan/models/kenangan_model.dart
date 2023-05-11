import 'package:cloud_firestore/cloud_firestore.dart';

class KenanganModel {
  final String caption;
  final Timestamp createdAt;
  final String imageUrl;
  final String kenanganId;

  KenanganModel({
    required this.caption,
    required this.createdAt,
    required this.imageUrl,
    required this.kenanganId,
  });

  factory KenanganModel.fromJson(Map<String, dynamic> json) {
    return KenanganModel(
      caption: json['caption'] ?? '',
      createdAt: json['created_at'] != null
          ? Timestamp.fromMillisecondsSinceEpoch(
              json['created_at'].millisecondsSinceEpoch)
          : Timestamp.now(),
      imageUrl: json['image_url'] ?? '',
      kenanganId: json['kenanganId'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'created_at': createdAt,
      'image_url': imageUrl,
      'kenanganId': kenanganId,
    };
  }
}
