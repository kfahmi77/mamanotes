class BulanPertamaAnakModel {
  final String documentId;
  final String bulanPertamaAnakId;
  final String imageUrl;

  BulanPertamaAnakModel({
    required this.documentId,
    required this.bulanPertamaAnakId,
    required this.imageUrl,
  });

  factory BulanPertamaAnakModel.fromJson(Map<String, dynamic> data) {
    final documentId = data['documentId'] ?? '';
    final imageUrl = data['foto_bulan_pertama_anak'] ?? '';
    final bulanPertamaAnakId = data['bulanPertamaAnakId'] ?? '';
    return BulanPertamaAnakModel(
      documentId: documentId,
      bulanPertamaAnakId: bulanPertamaAnakId,
      imageUrl: imageUrl,
    );
  }
}
