import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/modules/jurnal_anak/berdiri_anak/models/berdiri_anak_model.dart';
import 'package:mamanotes/app/modules/jurnal_anak/bulan_pertama_anak/models/bulan_pertama_anak_model.dart';
import 'package:mamanotes/app/modules/jurnal_anak/duduk_anak/models/duduk_anak_model.dart';
import 'package:mamanotes/app/modules/jurnal_anak/gigi_pertama_anak/models/gigi_pertama_anak_model.dart';
import 'package:mamanotes/app/modules/jurnal_anak/merangkak_anak/models/merangkak_anak_model.dart';
import 'package:mamanotes/app/modules/jurnal_anak/tahun_pertama_anak/models/tahun_pertama_anak_model.dart';
import 'package:mamanotes/app/modules/jurnal_anak/kata_pertama_anak/models/kata_pertama_anak_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

import '../../data/common/utils/firebase_snapshot.dart';
import 'kelahiran_anak/models/kelahiran_anak_model.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({Key? key, required this.documentId}) : super(key: key);
  final String documentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          'Preview Jurnal Anak',
          style: redTextStyle.copyWith(color: red, fontWeight: bold),
        ),
        elevation: 0,
      ),
      body: PdfPreview(
        build: (context) => generateDocument(),
      ),
    );
  }

  Future<Uint8List> generateDocument() async {
    final doc = pw.Document();

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    final ByteData bytes =
        await rootBundle.load('assets/images/logo_mamanote.png');
    final Uint8List logo = bytes.buffer.asUint8List();

    Uint8List backgroundKataPertamaImage =
        await loadImage('assets/images/bg.jpg');
    Uint8List backgroundGigiPertamaImage =
        await loadImage('assets/images/bg2.png');
    Uint8List backgroundMerangkak = await loadImage('assets/images/coba.jpg');
    Uint8List backgroundDuduk = await loadImage('assets/images/duduk.jpg');
    Uint8List backgrounBerdiri = await loadImage('assets/images/berdiri.jpg');
    Uint8List backgrounBBulanPertama =
        await loadImage('assets/images/bulan.jpg');
    Uint8List backgroundTahunPertama =
        await loadImage('assets/images/tahun.jpg');

    pw.SvgImage waktuIcon = await loadStringSvg('assets/svg/clock-regular.svg');
    pw.SvgImage tempatIcon = await loadStringSvg('assets/svg/marker.svg');
    pw.SvgImage tinggiIcon = await loadStringSvg('assets/svg/height.svg');
    pw.SvgImage beratIcon = await loadStringSvg('assets/svg/weight.svg');
    pw.SvgImage dokterIcon = await loadStringSvg('assets/svg/doctor.svg');
    pw.SvgImage ayahIcon = await loadStringSvg('assets/svg/man.svg');
    pw.SvgImage ibuIcon = await loadStringSvg('assets/svg/woman.svg');

    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await getJurnalAnakDocument(documentId, 'kelahiranAnak$documentId');
    final DocumentSnapshot<Map<String, dynamic>> snapshot2 =
        await getJurnalAnakDocument(documentId, 'kataAnakPertama$documentId');

    final DocumentSnapshot<Map<String, dynamic>> snapshot3 =
        await getJurnalAnakDocument(documentId, 'gigiPertamaAnak$documentId');
    final DocumentSnapshot<Map<String, dynamic>> snapshot4 =
        await getJurnalAnakDocument(documentId, 'merangkakAnakId$documentId');
    final DocumentSnapshot<Map<String, dynamic>> snapshot5 =
        await getJurnalAnakDocument(documentId, 'dudukAnakId$documentId');
    final DocumentSnapshot<Map<String, dynamic>> snapshot6 =
        await getJurnalAnakDocument(documentId, 'berdiriAnakId$documentId');
    final DocumentSnapshot<Map<String, dynamic>> snapshot7 =
        await getJurnalAnakDocument(
            documentId, 'bulanPertamaAnakId$documentId');
    final DocumentSnapshot<Map<String, dynamic>> snapshot8 =
        await getJurnalAnakDocument(
            documentId, 'tahunPertamaAnakId$documentId');

    final Map<String, dynamic>? data = snapshot.data();
    final Map<String, dynamic>? data2 = snapshot2.data();
    final Map<String, dynamic>? data3 = snapshot3.data();
    final Map<String, dynamic>? data4 = snapshot4.data();
    final Map<String, dynamic>? data5 = snapshot5.data();
    final Map<String, dynamic>? data6 = snapshot6.data();
    final Map<String, dynamic>? data7 = snapshot7.data();
    final Map<String, dynamic>? data8 = snapshot8.data();

    if (snapshot.exists) {
      final KelahiranAnak item = KelahiranAnak.fromJson(data!);
      final fotoKelahiran = await networkImage(item.urlFotoKelahiran);
      final fotoKaki = await networkImage(item.urlFotoCapKaki);
      final fotoBayi = await networkImage(item.urlFotoAnak);
      doc.addPage(
        pw.MultiPage(
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
          orientation: pw.PageOrientation.portrait,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          build: (pw.Context context) => <pw.Widget>[
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Image(
                  pw.MemoryImage(logo),
                  fit: pw.BoxFit.fitHeight,
                  height: 50.h,
                  width: 350.w,
                ),
              ],
            ),
            pw.Divider(
              thickness: 2,
              color: PdfColor.fromInt(red.value),
              height: 20.h,
              endIndent: 20.h,
              indent: 20,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  "Kelahiran Anak",
                  style: pw.TextStyle(
                    fontSize: 20.sp,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromInt(red.value),
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 20.h), // Tambahkan jarak antara halaman
            pw.Container(
              width: 500.w,
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(10),
                color: PdfColor.fromInt(red.value),
              ),
              child: pw.Column(
                children: [
                  rowKelahiranPdf(waktuIcon, item.waktuLahir),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(tempatIcon, item.tempatLahir),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(dokterIcon, item.petugasKesehatan),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(tinggiIcon, '${item.tinggiAnakLahir} cm'),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(beratIcon, '${item.beratAnakLahir} kg'),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(ayahIcon, item.doaAyah),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(ibuIcon, item.doaIbu),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(16.r),
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.Image(
                        fotoBayi,
                        fit: pw.BoxFit.contain,
                        width: 370.w,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(16.r),
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.Image(
                        fotoKaki,
                        fit: pw.BoxFit.contain,
                        width: 370.w,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(16.r),
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.Image(
                        fotoKelahiran,
                        fit: pw.BoxFit.contain,
                        width: 370.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Tidak ada data kelahiran anak',
                style: const pw.TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );
    }

    if (snapshot2.exists) {
      final KataPertamaAnakModel kataPertamaAnakModel =
          KataPertamaAnakModel.fromJson(data2!);

      // Add a page for each snapshot in the main document (doc)
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Retrieve PDF page size
            const pageFormat = PdfPageFormat.a4;
            final screenWidth = pageFormat.width;
            final screenHeight = pageFormat.height - 200;

            return pw.Stack(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Kata Pertama Anak",
                      style: pw.TextStyle(
                        fontSize: 20.sp,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(red.value),
                      ),
                    ),
                  ],
                ),
                pw.Center(
                  child: pw.Image(
                    pw.MemoryImage(backgroundKataPertamaImage),
                    width: screenWidth,
                    height: screenHeight,
                    fit: pw.BoxFit.fill,
                  ),
                ),
                pw.Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: pw.Center(
                    child: pw.Container(
                      width: 200.w,
                      child: pw.Expanded(
                        child: pw.Text(
                          kataPertamaAnakModel.kataPertama,
                          style: const pw.TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Tidak ada data kata pertama anak',
                style: const pw.TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );
    }

    if (snapshot3.exists) {
      final GigiPertamaAnakModel gigiPertamaAnak =
          GigiPertamaAnakModel.fromJson(data3!);
      final fotoGigi = await networkImage(gigiPertamaAnak.imageUrl);
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Retrieve PDF page size
            const pageFormat = PdfPageFormat.a4;
            final screenWidth = pageFormat.width;
            final screenHeight = pageFormat.height;

            return pw.Stack(
              children: [
                pw.Center(
                  child: pw.Image(
                    pw.MemoryImage(backgroundGigiPertamaImage),
                    width: screenWidth,
                    height: screenHeight,
                    fit: pw.BoxFit.fill,
                  ),
                ),
                pw.Positioned(
                  top: 120, // Jarak atas teks dari atas
                  left: 0,
                  right: 0,
                  child: pw.Center(
                    child: pw.Text(
                      "Gigi Pertama Anak",
                      style: pw.TextStyle(
                        fontSize: 20.sp,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(red.value),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: pw.Center(
                    child: pw.Container(
                      width: 400.w,
                      height: 300.h,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColor.fromInt(red.value),
                          width: 6,
                        ),
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.ClipRRect(
                        horizontalRadius: 10,
                        verticalRadius: 10,
                        child: pw.Image(fotoGigi),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Tidak ada data gigi pertama anak',
                style: const pw.TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );
    }
    if (snapshot4.exists) {
      final MerangkakAnakModel merangkakAnak =
          MerangkakAnakModel.fromJson(data4!);
      final fotoGigi = await networkImage(merangkakAnak.imageUrl);
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Retrieve PDF page size
            const pageFormat = PdfPageFormat.a4;
            final screenWidth = pageFormat.width;
            final screenHeight = pageFormat.height;

            return pw.Stack(
              children: [
                pw.Center(
                  child: pw.Image(
                    pw.MemoryImage(backgroundMerangkak),
                    width: screenWidth,
                    height: screenHeight,
                    fit: pw.BoxFit.fill,
                  ),
                ),
                pw.Positioned(
                  top: 120, // Jarak atas teks dari atas
                  left: 0,
                  right: 0,
                  child: pw.Center(
                    child: pw.Text(
                      "Anak Merangkak",
                      style: pw.TextStyle(
                        fontSize: 20.sp,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(red.value),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: pw.Center(
                    child: pw.Container(
                      width: 200.w,
                      height: 200.h,
                      child: pw.Image(fotoGigi),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Tidak ada foto anak merangkak',
                style: const pw.TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );
    }
    if (snapshot5.exists) {
      final DudukAnakModel dudukAnak = DudukAnakModel.fromJson(data5!);
      final fotoGigi = await networkImage(dudukAnak.imageUrl);
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Retrieve PDF page size
            const pageFormat = PdfPageFormat.a4;
            final screenWidth = pageFormat.width;
            final screenHeight = pageFormat.height;

            return pw.Stack(
              children: [
                pw.Center(
                  child: pw.Image(
                    pw.MemoryImage(backgroundDuduk),
                    width: screenWidth,
                    height: screenHeight,
                    fit: pw.BoxFit.contain,
                  ),
                ),
                pw.Positioned(
                  top: 120, // Jarak atas teks dari atas
                  left: 0,
                  right: 0,
                  child: pw.Center(
                    child: pw.Text(
                      "Anak Duduk",
                      style: pw.TextStyle(
                        fontSize: 20.sp,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(red.value),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: pw.Center(
                    child: pw.Container(
                      width: 400.w,
                      height: 300.h,
                      child: pw.Image(fotoGigi),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Tidak ada foto Anak duduk',
                style: const pw.TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );
    }
    if (snapshot6.exists) {
      final BerdiriAnakModel berdiriAnak = BerdiriAnakModel.fromJson(data6!);
      final fotoGigi = await networkImage(berdiriAnak.imageUrl);
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Retrieve PDF page size
            const pageFormat = PdfPageFormat.a4;
            final screenWidth = pageFormat.width;
            final screenHeight = pageFormat.height;

            return pw.Stack(
              children: [
                pw.Center(
                  child: pw.Image(
                    pw.MemoryImage(backgrounBerdiri),
                    width: screenWidth,
                    height: screenHeight,
                    fit: pw.BoxFit.contain,
                  ),
                ),
                pw.Positioned(
                  top: 180, // Jarak atas teks dari atas
                  left: 0,
                  right: 0,
                  child: pw.Center(
                    child: pw.Text(
                      "Anak Berdiri",
                      style: pw.TextStyle(
                        fontSize: 20.sp,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(red.value),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: pw.Center(
                    child: pw.Container(
                      width: 200.w,
                      height: 200.h,
                      child: pw.Image(fotoGigi),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Tidak ada foto Anak Berdiri',
                style: const pw.TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );
    }
    if (snapshot7.exists) {
      final BulanPertamaAnakModel bulanPertamaAnak =
          BulanPertamaAnakModel.fromJson(data7!);
      final fotoGigi = await networkImage(bulanPertamaAnak.imageUrl);
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Retrieve PDF page size
            const pageFormat = PdfPageFormat.a4;
            final screenWidth = pageFormat.width;
            final screenHeight = pageFormat.height;

            return pw.Stack(
              children: [
                pw.Center(
                  child: pw.Image(
                    pw.MemoryImage(backgrounBBulanPertama),
                    width: screenWidth,
                    height: screenHeight,
                    fit: pw.BoxFit.contain,
                  ),
                ),
                pw.Positioned(
                  top: 150, // Jarak atas teks dari atas
                  left: 0,
                  right: 0,
                  child: pw.Center(
                    child: pw.Text(
                      "Bulan Pertama Anak",
                      style: pw.TextStyle(
                        fontSize: 20.sp,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(red.value),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: pw.Center(
                    child: pw.Container(
                      width: 300.w,
                      height: 300.h,
                      child: pw.ClipOval(
                        child: pw.Image(fotoGigi),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Tidak ada foto Bulan Pertama Anak',
                style: const pw.TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );
    }
    if (snapshot8.exists) {
      final TahunPertamaAnakModel tahunPertamaAnak =
          TahunPertamaAnakModel.fromJson(data8!);
      final fotoGigi = await networkImage(tahunPertamaAnak.imageUrl);
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Retrieve PDF page size
            const pageFormat = PdfPageFormat.a4;
            final screenWidth = pageFormat.width;
            final screenHeight = pageFormat.height;

            return pw.Stack(
              children: [
                pw.Center(
                  child: pw.Image(
                    pw.MemoryImage(backgroundTahunPertama),
                    width: screenWidth,
                    height: screenHeight,
                    fit: pw.BoxFit.contain,
                  ),
                ),
                pw.Positioned(
                  top: 150, // Jarak atas teks dari atas
                  left: 0,
                  right: 0,
                  child: pw.Center(
                    child: pw.Text(
                      "Tahun Pertama Anak",
                      style: pw.TextStyle(
                        fontSize: 20.sp,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(red.value),
                      ),
                    ),
                  ),
                ),
                pw.Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: pw.Center(
                    child: pw.Container(
                      width: 300.w,
                      height: 300.h,
                      child: pw.ClipOval(
                        child: pw.Image(fotoGigi),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Tidak ada foto Tahun Pertama Anak',
                style: const pw.TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );
    }

    return await doc.save();
  }

  pw.Padding rowKelahiranPdf(pw.SvgImage waktuIcon, String text) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(16.r),
      child: pw.Row(children: [
        waktuIcon,
        pw.SizedBox(width: 8.w),
        pw.SizedBox(
          height: 50.h,
          child: pw.VerticalDivider(
            thickness: 1,
            color: PdfColor.fromInt(white.value),
          ),
        ),
        pw.SizedBox(width: 8.w),
        pw.Flexible(
          child: pw.Text(text,
              style: pw.TextStyle(
                  color: PdfColor.fromInt(white.value), fontSize: 16.sp)),
        ),
      ]),
    );
  }
}

Future<pw.SvgImage> loadStringSvg(String svg) async {
  var svgRaw = await rootBundle.loadString(svg);
  final icon = pw.SvgImage(
      svg: svgRaw, width: 30.w, colorFilter: PdfColor.fromInt(white.value));
  return icon;
}

Future<Uint8List> loadImage(String imagePath) async {
  final ByteData bytes = await rootBundle.load(imagePath);
  return bytes.buffer.asUint8List();
}
