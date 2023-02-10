extension SendinBlueDateTimeExtension on DateTime {
  /// Returns the date in the format YYYY-MM-DD
  String toSendinBlueFormat() {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
