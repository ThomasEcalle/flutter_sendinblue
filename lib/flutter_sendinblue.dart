library flutter_sendingblue;

import 'src/model/contact.dart';
import 'src/model/sendinblue_configuration.dart';
import 'src/provider/sendingblue_api_provider.dart';
import 'src/sendinblue_repository.dart';

export 'src/exceptions/sendingblue_api_exception.dart';
export 'src/model/contact.dart';
export 'src/model/sendinblue_configuration.dart';

class Sendinblue {
  static Sendinblue? _instance;

  static void initialize({
    required SendinblueConfiguration configuration,
  }) {
    _instance = Sendinblue._(
      configuration,
      SendinblueRepository(
        sendingBlueProvider: SendinblueApiProvider(apiKey: configuration.apiKey),
      ),
    );
  }

  static Sendinblue get instance {
    final instance = _instance;
    if (instance == null) {
      throw Exception('Sendinblue has not been initialized');
    }
    return instance;
  }

  final SendinblueConfiguration _configuration;
  final SendinblueRepository _repository;

  Sendinblue._(this._configuration, this._repository);

  Future<int> createContact({required String email}) async {
    return _repository.createContact(email: email);
  }

  Future<List<Contact>> getAllContacts() async {
    return _repository.getAllContacts();
  }

  Future<List<Contact>> getContacts({int offset = 0, limit = 50}) async {
    return _repository.getContacts(offset: offset, limit: limit);
  }

  Future<Contact> getContact({required String email}) async {
    return _repository.getContact(email: email);
  }

  Future<void> deleteContact({required String email}) async {
    return _repository.deleteContact(email: email);
  }

  Future<void> addContactInEmailsBlackList({required String email}) async {
    return _repository.addContactInEmailsBlackList(email: email);
  }

  Future<void> removeContactFromEmailsBlackList({required String email}) async {
    return _repository.removeContactFromEmailsBlackList(email: email);
  }

  Future<void> updateContactProperties({required String email, required Map<String, dynamic> properties}) async {
    return _repository.updateContactProperties(email: email, properties: properties);
  }
}
