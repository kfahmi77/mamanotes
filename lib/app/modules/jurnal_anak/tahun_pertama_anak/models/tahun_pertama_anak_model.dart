class TahunPertamaAnakModel {
  final String documentId;
  final String tahunPertamaAnakId;
  final String imageUrl;

  TahunPertamaAnakModel({
    required this.documentId,
    required this.tahunPertamaAnakId,
    required this.imageUrl,
  });

  factory TahunPertamaAnakModel.fromJson(Map<String, dynamic> data) {
    final documentId = data['documentId'] ?? '';
    final imageUrl = data['foto_tahun_pertama_anak'] ?? '';
    final tahunPertamaAnakId = data['tahunPertamaAnakId'] ?? '';
    return TahunPertamaAnakModel(
      documentId: documentId,
      tahunPertamaAnakId: tahunPertamaAnakId,
      imageUrl: imageUrl,
    );
  }
}
