import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/common/widget/custom_card_pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';
import 'package:flutter/material.dart' as mt;

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => generateDocument(),
      ),
    );
  }

  Future<Uint8List> generateDocument() async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    final ByteData bytes =
        await rootBundle.load('assets/images/logo_mamanote.png');
    final Uint8List logo = bytes.buffer.asUint8List();
    final ByteData stringImg =
        await rootBundle.load('assets/images/photo1.png');
    final Uint8List coba = stringImg.buffer.asUint8List();
    pw.SvgImage waktuIcon = await loadStringSvg('assets/svg/clock-regular.svg');
    pw.SvgImage tempatIcon = await loadStringSvg('assets/svg/marker.svg');
    pw.SvgImage tinggiIcon = await loadStringSvg('assets/svg/height.svg');
    pw.SvgImage beratIcon = await loadStringSvg('assets/svg/weight.svg');
    pw.SvgImage dokterIcon = await loadStringSvg('assets/svg/doctor.svg');
    pw.SvgImage ayahIcon = await loadStringSvg('assets/svg/man.svg');
    pw.SvgImage ibuIcon = await loadStringSvg('assets/svg/woman.svg');

    doc.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: font1,
          bold: font2,
        ),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          if (context.pageNumber == 1) {
            return pw.SizedBox();
          }
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 0.5 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 0.5 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      bottom:
                          pw.BorderSide(width: 0.5, color: PdfColors.grey))),
              child: pw.Text('Mamanote',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        footer: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text(
                  'Halaman ${context.pageNumber} dari ${context.pagesCount}',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Image(pw.MemoryImage(logo),
                fit: pw.BoxFit.fitHeight, height: 50.h, width: 270.w),
          ]),
          pw.Divider(
              thickness: 2,
              color: PdfColor.fromInt(red.value),
              height: 20.h,
              endIndent: 20.h,
              indent: 20),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text(
              "Kelahiran Anak",
              style: pw.TextStyle(
                  fontSize: 20.sp,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromInt(red.value)),
            ),
          ]),
          pw.Container(
              decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(10),
                  color: PdfColor.fromInt(red.value)),
              child: pw.Column(children: [
                rowKelahiranPdf(waktuIcon, '20:30'),
                pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10),
                rowKelahiranPdf(
                    tempatIcon, 'Rumah Sakit Hasan Sadikin Bandung'),
                pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10),
                rowKelahiranPdf(dokterIcon, 'Dokter Andini'),
                pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10),
                rowKelahiranPdf(tinggiIcon, '10 cm'),
                pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10),
                rowKelahiranPdf(beratIcon, '3.5 kg'),
                pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10),
                rowKelahiranPdf(ayahIcon, 'amin'),
                pw.Divider(
                    thickness: 2,
                    color: PdfColor.fromInt(white.value),
                    height: 20.h,
                    endIndent: 10.h,
                    indent: 10),
                rowKelahiranPdf(ibuIcon, 'amin'),
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
                      pw.MemoryImage(
                          coba), // Replace imageBytes with your image bytes
                      fit: pw.BoxFit.contain,
                      width: 370.w,
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );

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
