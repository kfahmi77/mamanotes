class DudukAnakModel {
  final String documentId;
  final String dudukAnakId;
  final String imageUrl;

  DudukAnakModel({
    required this.documentId,
    required this.dudukAnakId,
    required this.imageUrl,
  });

  factory DudukAnakModel.fromJson(Map<String, dynamic> data) {
    final documentId = data['documentId'] ?? '';
    final imageUrl = data['foto_duduk_anak'] ?? '';
    final dudukAnakId = data['dudukAnakId'] ?? '';
    return DudukAnakModel(
      documentId: documentId,
      dudukAnakId: dudukAnakId,
      imageUrl: imageUrl,
    );
  }
}
