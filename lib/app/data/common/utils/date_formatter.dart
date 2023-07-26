import 'package:intl/intl.dart';

String formatTanggalLahir(DateTime tanggalLahir) {
  final DateFormat formatter = DateFormat('d MMM yyyy', 'id_ID');
  return formatter.format(tanggalLahir);
}