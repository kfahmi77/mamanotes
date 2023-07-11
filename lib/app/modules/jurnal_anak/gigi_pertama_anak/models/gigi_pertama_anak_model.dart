class GigiPertamaAnakModel {
  final String documentId;
  final String gigiPertamaAnakId;
  final String imageUrl;

  GigiPertamaAnakModel({
    required this.documentId,
    required this.gigiPertamaAnakId,
    required this.imageUrl,
  });

  factory GigiPertamaAnakModel.fromJson(Map<String, dynamic> data) {
    final documentId = data['documentId'] ?? '';
    final imageUrl = data['foto_gigi_anak'] ?? '';
    final gigiPertamaAnakId = data['gigiPertamaId'] ?? '';
    return GigiPertamaAnakModel(
      documentId: documentId,
      gigiPertamaAnakId: gigiPertamaAnakId,
      imageUrl: imageUrl,
    );
  }
}
