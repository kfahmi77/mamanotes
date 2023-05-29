import 'package:cloud_firestore/cloud_firestore.dart';

class AnakModel {
  final String artisNama;
  final String fotoAnak;
  final String golonganDarah;
  final String jenisKelamin;
  final String namaLengkap;
  final String namaPanggilan;
  final Timestamp tanggalLahir;
  final String tempat;
  final String uid;
  final String docId;

  AnakModel({
    required this.artisNama,
    required this.fotoAnak,
    required this.golonganDarah,
    required this.jenisKelamin,
    required this.namaLengkap,
    required this.namaPanggilan,
    required this.tanggalLahir,
    required this.tempat,
    required this.uid,
    required this.docId
  });

  factory AnakModel.fromJson(Map<String, dynamic> json) {
    return AnakModel(
      artisNama: json['arti_nama'],
      fotoAnak: json['foto_anak'],
      golonganDarah: json['golongan_darah'],
      jenisKelamin: json['jenis_kelamin'],
      namaLengkap: json['nama_lengkap'],
      namaPanggilan: json['nama_panggilan'],
      tanggalLahir: json['tanggal_lahir'],
      tempat: json['tempat'],
      uid: json['uid'],
      docId: json['anakId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arti_nama': artisNama,
      'foto_anak': fotoAnak,
      'golongan_darah': golonganDarah,
      'jenis_kelamin': jenisKelamin,
      'nama_lengkap': namaLengkap,
      'nama_panggilan': namaPanggilan,
      'tanggal_lahir': tanggalLahir,
      'tempat': tempat,
      'uid': uid,
      'anakId': docId
    };
  }
}
