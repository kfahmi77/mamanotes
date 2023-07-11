String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  String twoDigitHours = twoDigits(duration.inHours);
  return [
    if (duration.inHours > 0) twoDigitHours,
    twoDigitMinutes,
    twoDigitSeconds,
  ].join(':');
}
