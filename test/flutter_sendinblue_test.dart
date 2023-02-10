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

  group('End to End tests', () {
    const testUserEmail = 'test_user@gmail.com';

    setUpAll(() async {
      const apiKey = 'add_your_api_key_here';

      Sendinblue.initialize(
        configuration: SendinblueConfiguration(
          apiKey: apiKey,
        ),
      );
    });

    test('Should create a contact', () async {
      final contactId = await Sendinblue.instance.createContact(
        email: testUserEmail,
      );
      expect(contactId, isNotNull);
    });

    test('Should get a contact', () async {
      final contact = await Sendinblue.instance.getContact(
        email: testUserEmail,
      );
      expect(contact, isNotNull);
      expect(contact.email, testUserEmail);
    });

    test('Should update a contact', () async {
      final contact =
          await Sendinblue.instance.getContact(email: testUserEmail);
      expect(contact, isNotNull);
      expect(contact.email, testUserEmail);

      await Sendinblue.instance.updateContactProperties(
        email: testUserEmail,
        properties: {
          'NOM': 'John',
        },
      );

      final updatedContact =
          await Sendinblue.instance.getContact(email: testUserEmail);

      expect(updatedContact, isNotNull);
      expect(updatedContact.email, testUserEmail);
      expect(updatedContact.attributes['NOM'], 'John');
    });

    test('Should delete a contact', () async {
      final contact =
          await Sendinblue.instance.getContact(email: testUserEmail);
      expect(contact, isNotNull);
      expect(contact.email, testUserEmail);

      await Sendinblue.instance.deleteContact(email: testUserEmail);

      expect(() => Sendinblue.instance.getContact(email: testUserEmail),
          throwsA(isA<SendinblueApiException>()));
    });
  });
}
