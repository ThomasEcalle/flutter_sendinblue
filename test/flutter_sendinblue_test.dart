import 'package:flutter_sendinblue/flutter_sendinblue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sendinblue initialization', () {
    test('Should throw if used without initialization', () {
      expect(() => Sendinblue.instance, throwsException);
    });

    test('Should not throw if used after initialization', () {
      Sendinblue.initialize(configuration: SendinblueConfiguration(apiKey: ''));
      expect(() => Sendinblue.instance, returnsNormally);
    });
  });
}
