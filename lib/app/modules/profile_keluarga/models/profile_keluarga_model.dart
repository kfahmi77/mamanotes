import 'package:cloud_firestore/cloud_firestore.dart';

class Keluarga {
  final String docId;
  final String uid;
  final String namaKeluarga;
  final String mottoKeluarga;
  final String visiMisi;
  final String alamatRumah;
  final Ayah ayah;
  final Ibu ibu;

  Keluarga({
    required this.docId,
    required this.uid,
    required this.namaKeluarga,
    required this.mottoKeluarga,
    required this.visiMisi,
    required this.alamatRumah,
    required this.ayah,
    required this.ibu,
  });

  Map<String, dynamic> toJson() {
    return {
      'namaKeluarga': namaKeluarga,
      'mottoKeluarga': mottoKeluarga,
      'visiMisi': visiMisi,
      'alamatRumah': alamatRumah,
      'ayah': ayah.toJson(),
      'ibu': ibu.toJson(),
    };
  }

  factory Keluarga.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Keluarga(
      docId: doc.id,
      uid: data['uid'],
      namaKeluarga: data['namaKeluarga'],
      mottoKeluarga: data['mottoKeluarga'],
      visiMisi: data['visiMisi'],
      alamatRumah: data['alamatRumah'],
      ayah: Ayah.fromMap(data['ayah']),
      ibu: Ibu.fromMap(data['ibu']),
    );
  }
}

class Ayah {
  final String nama;
  final String foto;

  Ayah({
    required this.nama,
    required this.foto,
  });

  factory Ayah.fromMap(Map<String, dynamic> map) {
    return Ayah(
      nama: map['nama'],
      foto: map['foto'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'foto': foto,
    };
  }
}

class Ibu {
  final String nama;
  final String foto;

  Ibu({
    required this.nama,
    required this.foto,
  });
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'foto': foto,
    };
  }

  factory Ibu.fromMap(Map<String, dynamic> map) {
    return Ibu(
      nama: map['nama'],
      foto: map['foto'],
    );
  }
}
