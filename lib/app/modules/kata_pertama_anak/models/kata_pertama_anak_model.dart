class KataPertamaAnakModel {
  final String kataPertama;
  final String documentId;
  final String kataPertamaAnakId;

  final String audio;

  KataPertamaAnakModel({
    required this.documentId,
    required this.kataPertamaAnakId,
    required this.kataPertama,
    required this.audio,
  });

  factory KataPertamaAnakModel.fromJson(Map<String, dynamic> json) =>
      KataPertamaAnakModel(
        documentId: json['documentId'],
        kataPertamaAnakId: json['kataPertamaId'],
        kataPertama: json['kata_pertama'],
        audio: json['suara'],
      );

  Map<String, dynamic> toJson() => {
        'kata_pertama': kataPertama,
        'suara': audio,
      };
}
