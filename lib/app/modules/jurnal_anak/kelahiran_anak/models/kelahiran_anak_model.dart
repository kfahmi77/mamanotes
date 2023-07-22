class KelahiranAnak {
  final String anakId;
  final String kelahiranAnakId;
  final String urlFotoAnak;
  final String tempatLahir;
  final String waktuLahir;
  final String urlFotoKelahiran;
  final String doaAyah;
  final String urlFotoCapKaki;
  final num tinggiAnakLahir;
  final String petugasKesehatan;
  final String doaIbu;
  final num beratAnakLahir;

  KelahiranAnak({
    required this.anakId,
    required this.kelahiranAnakId,
    required this.urlFotoAnak,
    required this.tempatLahir,
    required this.waktuLahir,
    required this.urlFotoKelahiran,
    required this.doaAyah,
    required this.urlFotoCapKaki,
    required this.tinggiAnakLahir,
    required this.petugasKesehatan,
    required this.doaIbu,
    required this.beratAnakLahir,
  });

  factory KelahiranAnak.fromJson(Map<String, dynamic> json) {
    return KelahiranAnak(
      anakId: json['anakId'] ?? '',
      kelahiranAnakId: json['kelahiranAnakId'] ?? '',
      urlFotoAnak: json['urlFotoAnak'] ?? '',
      tempatLahir: json['tempatLahir'] ?? '',
      waktuLahir: json['waktuLahir'] ?? '',
      urlFotoKelahiran: json['urlFotoKelahiran'] ?? '',
      doaAyah: json['doaAyah'] ?? '',
      urlFotoCapKaki: json['urlFotoCapKaki'] ?? '',
      tinggiAnakLahir: json['tinggiAnakLahir'] ?? 0,
      petugasKesehatan: json['petugasKesehatan'] ?? '',
      doaIbu: json['doaIbu'] ?? '',
      beratAnakLahir: json['beratAnakLahir'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'KelahiranAnakId': kelahiranAnakId,
      'urlFotoAnak': urlFotoAnak,
      'tempatLahir': tempatLahir,
      'waktuLahir': waktuLahir,
      'urlFotoKelahiran': urlFotoKelahiran,
      'doaAyah': doaAyah,
      'urlFotoCapKaki': urlFotoCapKaki,
      'tinggiAnakLahir': tinggiAnakLahir,
      'petugasKesehatan': petugasKesehatan,
      'doaIbu': doaIbu,
      'beratAnakLahir': beratAnakLahir,
    };
  }
}
