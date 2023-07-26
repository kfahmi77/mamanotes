class MerangkakAnakModel {
  final String documentId;
  final String merangkakAnakId;
  final String imageUrl;

  MerangkakAnakModel({
    required this.documentId,
    required this.merangkakAnakId,
    required this.imageUrl,
  });

  factory MerangkakAnakModel.fromJson(Map<String, dynamic> data) {
    final documentId = data['documentId'] ?? '';
    final imageUrl = data['foto_merangkak_anak'] ?? '';
    final merangkakAnakId = data['merangkakAnakId'] ?? '';
    return MerangkakAnakModel(
      documentId: documentId,
      merangkakAnakId: merangkakAnakId,
      imageUrl: imageUrl,
    );
  }
}
