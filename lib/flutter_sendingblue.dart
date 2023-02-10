library flutter_sendingblue;

import 'src/model/contact.dart';
import 'src/model/sendingblue_configuration.dart';
import 'src/provider/sendingblue_api_provider.dart';
import 'src/sendingblue_repository.dart';

class SendinBlue {
  static SendinBlue? _instance;

  static void initialize({
    required SendingBlueConfiguration configuration,
  }) {
    _instance = SendinBlue._(
      configuration,
      SendingBlueRepository(
        sendingBlueProvider: SendingBlueApiProvider(apiKey: configuration.apiKey),
      ),
    );
  }

  static SendinBlue get instance {
    final instance = _instance;
    if (instance == null) {
      throw Exception('SendingBlue has not been initialized');
    }
    return instance;
  }

  final SendingBlueConfiguration _configuration;
  final SendingBlueRepository _repository;

  SendinBlue._(this._configuration, this._repository);

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

  Future<void> addUserInEmailsBlackList({required String email}) async {
    return _repository.addUserInEmailsBlackList(email: email);
  }

  Future<void> removeUserFromEmailsBlackList({required String email}) async {
    return _repository.removeUserFromEmailsBlackList(email: email);
  }

  Future<void> updateContactProperties({required String email, required Map<String, dynamic> properties}) async {
    return _repository.updateContactProperties(email: email, properties: properties);
  }
}
