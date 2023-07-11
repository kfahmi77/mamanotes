class BerdiriAnakModel {
  final String documentId;
  final String gigiPertamaAnakId;
  final String imageUrl;

  BerdiriAnakModel({
    required this.documentId,
    required this.gigiPertamaAnakId,
    required this.imageUrl,
  });

  factory BerdiriAnakModel.fromJson(Map<String, dynamic> data) {
    final documentId = data['documentId'] ?? '';
    final imageUrl = data['foto_berdiri_anak'] ?? '';
    final gigiPertamaAnakId = data['berdiriAnakId'] ?? '';
    return BerdiriAnakModel(
      documentId: documentId,
      gigiPertamaAnakId: gigiPertamaAnakId,
      imageUrl: imageUrl,
    );
  }
}
