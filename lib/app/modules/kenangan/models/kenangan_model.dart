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

  factory KenanganModel.fromJson(DocumentSnapshot json) {
    Map data = json.data() as Map<String, dynamic>;
    return KenanganModel(
      caption: data['caption'] ?? '',
      createdAt: data['create_at'] != null
          ? Timestamp.fromMillisecondsSinceEpoch(
              data['create_at'].millisecondsSinceEpoch)
          : Timestamp.now(),
      imageUrl: data['image_url'] ?? '',
      kenanganId: data['kenanganId'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'create_at': createdAt,
      'image_url': imageUrl,
      'kenanganId': kenanganId,
    };
  }
}
