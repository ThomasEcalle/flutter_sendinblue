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

  /// Initialize the Sendinblue package
  ///
  /// [apiKey] is the API key of your Sendinblue account
  /// Note that this method should be called before using any other method of this package.
  static void initialize({
    required SendinblueConfiguration configuration,
  }) {
    _instance = Sendinblue._(
      SendinblueRepository(
        sendingBlueProvider:
            SendinblueApiProvider(apiKey: configuration.apiKey),
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

  final SendinblueRepository _repository;

  Sendinblue._(this._repository);

  /// Create a contact based on [email].
  Future<int> createContact({required String email}) async {
    return _repository.createContact(email: email);
  }

  /// Get all the contacts without any filter nor pagination.
  Future<List<Contact>> getAllContacts() async {
    return _repository.getAllContacts();
  }

  /// Get contacts with pagination based on [offset] and [limit].
  ///
  /// getContacts(offset: 0, limit: 50) will return the first 50 contacts.
  /// getContacts(offset: 50, limit: 50) will return the second 50 contacts.
  /// etc.
  Future<List<Contact>> getContacts({int offset = 0, limit = 50}) async {
    return _repository.getContacts(offset: offset, limit: limit);
  }

  /// Get a contact based on [email].
  Future<Contact> getContact({required String email}) async {
    return _repository.getContact(email: email);
  }

  /// Delete a contact based on [email].
  Future<void> deleteContact({required String email}) async {
    return _repository.deleteContact(email: email);
  }

  /// Add a contact in the emails black list based on [email].
  Future<void> addContactInEmailsBlackList({required String email}) async {
    return _repository.addContactInEmailsBlackList(email: email);
  }

  /// Remove a contact from the emails black list based on [email].
  Future<void> removeContactFromEmailsBlackList({required String email}) async {
    return _repository.removeContactFromEmailsBlackList(email: email);
  }

  /// Update a contact [properties] based on its [email].
  ///
  /// Note that the [properties] will only be handled by Sendinblue if they are already defined in your project.
  Future<void> updateContactProperties({
    required String email,
    required Map<String, dynamic> properties,
  }) async {
    return _repository.updateContactProperties(
        email: email, properties: properties);
  }
}
