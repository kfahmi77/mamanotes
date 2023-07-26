import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mamanotes/app/data/common/utils/date_formatter.dart';

void main() {
setUpAll(() {
    initializeDateFormatting('id_ID', 'id_ID');
  });
  test('Format tanggal lahir', () {
    DateTime tanggalLahir = DateTime(1990, 12, 31);
    expect(formatTanggalLahir(tanggalLahir), '31 Des 1990');
  });


  test('Format tanggal lahir tanpa 0 dan bulan', () {
    DateTime tanggalLahir = DateTime(2000, 1, 5);
    expect(formatTanggalLahir(tanggalLahir), '5 Jan 2000');
  });

  test('Format tanggal lahir dengan 0 dan bulan', () {
    DateTime tanggalLahir = DateTime(1985, 07, 03);
    expect(formatTanggalLahir(tanggalLahir), '3 Jul 1985');
  });

  test('Format tanggal lahir 30 hari', () {
    DateTime tanggalLahir = DateTime.now().add(Duration(days: 30));
    expect(formatTanggalLahir(tanggalLahir), isNotNull);
  });
}