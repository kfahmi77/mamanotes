class KelahiranAnak {
  final String kelahiranAnakId;
  final String birthPhotoUrl;
  final String birthPlace;
  final String birthTime;
  final String deliveryPhotoUrl;
  final String fatherPrayer;
  final String footPrintPhotoUrl;
  final num height;
  final String medicalPersonnel;
  final String motherPrayer;
  final num weight;

  KelahiranAnak({
    required this.kelahiranAnakId,
    required this.birthPhotoUrl,
    required this.birthPlace,
    required this.birthTime,
    required this.deliveryPhotoUrl,
    required this.fatherPrayer,
    required this.footPrintPhotoUrl,
    required this.height,
    required this.medicalPersonnel,
    required this.motherPrayer,
    required this.weight,
  });

  factory KelahiranAnak.fromJson(Map<String, dynamic> json) {
    return KelahiranAnak(
      kelahiranAnakId: json['KelahiranAnakId'] ?? '',
      birthPhotoUrl: json['birthPhotoUrl'] ?? '',
      birthPlace: json['birthPlace'] ?? '',
      birthTime: json['birthTime'] ?? '',
      deliveryPhotoUrl: json['deliveryPhotoUrl'] ?? '',
      fatherPrayer: json['fatherPrayer'] ?? '',
      footPrintPhotoUrl: json['footPrintPhotoUrl'] ?? '',
      height: json['height'] ?? 0,
      medicalPersonnel: json['medicalPersonnel'] ?? '',
      motherPrayer: json['motherPrayer'] ?? '',
      weight: json['weight'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'KelahiranAnakId': kelahiranAnakId,
      'birthPhotoUrl': birthPhotoUrl,
      'birthPlace': birthPlace,
      'birthTime': birthTime,
      'deliveryPhotoUrl': deliveryPhotoUrl,
      'fatherPrayer': fatherPrayer,
      'footPrintPhotoUrl': footPrintPhotoUrl,
      'height': height,
      'medicalPersonnel': medicalPersonnel,
      'motherPrayer': motherPrayer,
      'weight': weight,
    };
  }
}
