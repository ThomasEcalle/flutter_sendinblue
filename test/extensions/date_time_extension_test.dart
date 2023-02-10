import 'package:flutter_sendinblue/src/extensions/date_time_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SendinBlueDateTimeExtension', () {
    test('Should correctly format a DateTime', () {
      final date = DateTime(2021, 1, 1);
      expect(date.toSendinBlueFormat(), '2021-01-01');
    });
  });
}
