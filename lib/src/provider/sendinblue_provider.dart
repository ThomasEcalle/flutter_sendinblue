import '../model/contact.dart';

abstract class SendinblueProvider {
  final String apiKey;

  SendinblueProvider({required this.apiKey});

  Future<int> createContact({required String email});

  Future<List<Contact>> getAllContacts();

  Future<List<Contact>> getContacts({required int offset, required int limit});

  Future<Contact> getContact({required String email});

  Future<void> deleteContact({required String email});

  Future<void> addContactInEmailsBlackList({required String email});

  Future<void> removeContactFromEmailsBlackList({required String email});

  Future<void> updateContactProperties({required String email, required Map<String, dynamic> properties});
}
