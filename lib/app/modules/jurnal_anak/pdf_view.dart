import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/modules/kata_pertama_anak/models/kata_pertama_anak_model.dart';
import 'package:mamanotes/app/modules/kata_pertama_anak/views/kata_pertama_anak_view.dart';
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
    final ByteData bytes2 = await rootBundle.load('assets/images/bg.jpg');
    final Uint8List backgroundKataPertama = bytes2.buffer.asUint8List();
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
    final Map<String, dynamic>? data = snapshot.data();
    final Map<String, dynamic>? data2 = snapshot2.data();

    if (snapshot.exists) {
      final KelahiranAnak item = KelahiranAnak.fromJson(data!);
      final fotoKelahiran = await networkImage(item.deliveryPhotoUrl);
      final fotoKaki = await networkImage(item.footPrintPhotoUrl);
      final fotoBayi = await networkImage(item.birthPhotoUrl);
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
                  width: 320.w,
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
                  rowKelahiranPdf(waktuIcon, item.birthTime),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(tempatIcon, item.birthPlace),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(dokterIcon, item.medicalPersonnel),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(tinggiIcon, '${item.height} cm'),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(beratIcon, '${item.weight} kg'),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(ayahIcon, item.fatherPrayer),
                  pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10,
                  ),
                  rowKelahiranPdf(ibuIcon, item.motherPrayer),
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
                        border: pw.Border.all(
                          width: 4,
                          color: PdfColor.fromInt(white.value),
                        ),
                      ),
                      child: pw.Image(
                        fotoBayi, // Replace imageBytes with your image bytes
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
                        border: pw.Border.all(
                          width: 4,
                          color: PdfColor.fromInt(white.value),
                        ),
                      ),
                      child: pw.Image(
                        fotoKaki, // Replace imageBytes with your image bytes
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
                        fotoKelahiran, // Replace imageBytes with your image bytes
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
                style: pw.TextStyle(fontSize: 24),
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
                    pw.MemoryImage(backgroundKataPertama),
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
                style: pw.TextStyle(fontSize: 24),
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
