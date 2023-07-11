// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import '../../../modules/jurnal_anak/pdf_view.dart';

// class CustomCardPdf {
//   final String title;
//   final String subtitle;
//   final String iconData;
//   final PdfColor backgroundColor;
//   final PdfColor textColor;

//   CustomCardPdf({
//     required this.title,
//     required this.subtitle,
//     required this.iconData,
//     this.backgroundColor = PdfColors.white,
//     this.textColor = PdfColors.black,
//   });

//   pw.Widget buildPdf() {
//     Future<pw.SvgImage> waktuIcon =  loadStringSvg(iconData);
//     return pw.Container(
//       color: backgroundColor,
//       child: pw.Padding(
//         padding: const pw.EdgeInsets.all(16),
//         child: pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             waktuIcon,
//             pw.SizedBox(height: 16),
//             pw.Text(
//               title,
//               style: pw.TextStyle(
//                 fontSize: 18,
//                 fontWeight: pw.FontWeight.bold,
//                 color: textColor,
//               ),
//             ),
//             pw.SizedBox(height: 8),
//             pw.Text(
//               subtitle,
//               style: pw.TextStyle(
//                 fontSize: 16,
//                 fontWeight: pw.FontWeight.normal,
//                 color: textColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
