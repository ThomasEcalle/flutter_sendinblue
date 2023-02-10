import 'model/contact.dart';
import 'provider/sendinblue_provider.dart';

class SendinblueRepository {
  final SendinblueProvider sendingBlueProvider;

  SendinblueRepository({required this.sendingBlueProvider});

  Future<int> createContact({required String email}) async {
    return await sendingBlueProvider.createContact(email: email);
  }

  Future<void> deleteContact({required String email}) async {
    return await sendingBlueProvider.deleteContact(email: email);
  }

  Future<List<Contact>> getAllContacts() async {
    return await sendingBlueProvider.getAllContacts();
  }

  Future<List<Contact>> getContacts({required int offset, required int limit}) async {
    return await sendingBlueProvider.getContacts(offset: offset, limit: limit);
  }

  Future<Contact> getContact({required String email}) async {
    return await sendingBlueProvider.getContact(email: email);
  }

  Future<void> addContactInEmailsBlackList({required String email}) async {
    return await sendingBlueProvider.addContactInEmailsBlackList(email: email);
  }

  Future<void> removeContactFromEmailsBlackList({required String email}) async {
    return await sendingBlueProvider.removeContactFromEmailsBlackList(email: email);
  }

  Future<void> updateContactProperties({required String email, required Map<String, dynamic> properties}) async {
    return await sendingBlueProvider.updateContactProperties(email: email, properties: properties);
  }
}
