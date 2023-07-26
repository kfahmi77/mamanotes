import 'package:flutter_test/flutter_test.dart';
import 'package:mamanotes/app/data/common/utils/number_formatter.dart';

void main() {
  test('Format waktu jam,menit,detik', () {
    Duration duration = const Duration(hours: 2, minutes: 30, seconds: 45);
    expect(formatTime(duration), '02:30:45');
  });

  test('Format waktu menit,detik', () {
    Duration duration = const Duration(minutes: 45, seconds: 30);
    expect(formatTime(duration), '45:30');
  });

  test('Format waktu detik', () {
    Duration duration = const Duration(seconds: 45);
    expect(formatTime(duration), '00:45');
  });

  test('Format waktu jam', () {
    Duration duration = const Duration(hours: 2);
    expect(formatTime(duration), '02:00:00');
  });

  // Test case 5: Testing for zero duration
  test('Format 0', () {
    Duration duration = Duration.zero;
    expect(formatTime(duration), '00:00');
  });
}