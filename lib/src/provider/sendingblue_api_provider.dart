import 'dart:convert';

import 'package:http/http.dart' as http;

import '../exceptions/sendingblue_api_exception.dart';
import '../model/contact.dart';
import 'sendinblue_provider.dart';

class SendinblueApiProvider extends SendinblueProvider {
  SendinblueApiProvider({required super.apiKey});

  final String _baseUrl = 'https://api.sendinblue.com/v3';

  @override
  Future<int> createContact({required String email}) async {
    final json = await _post(path: '/contacts', body: {'email': email});
    return json['id'];
  }

  @override
  Future<List<Contact>> getAllContacts({
    int offset = 0,
    int limit = 50,
  }) async {
    final List<Contact> contacts = [];
    do {
      final retrieveContacts = await getContacts(offset: offset, limit: limit);
      contacts.addAll(retrieveContacts);
      offset += limit;
    } while (contacts.length % limit == 0);

    return contacts;
  }

  @override
  Future<List<Contact>> getContacts({int offset = 0, int limit = 50}) async {
    final json = await _get(path: '/contacts?limit=$limit&offset=$offset');
    final List<Contact> result = [];
    json['contacts'].forEach((contact) {
      result.add(Contact.fromJson(contact));
    });

    return result;
  }

  @override
  Future<Contact> getContact({required String email}) async {
    final json = await _get(path: '/contacts/$email');
    return Contact.fromJson(json);
  }

  @override
  Future<void> deleteContact({required String email}) async {
    await _delete(path: '/contacts/$email');
  }

  @override
  Future<void> addContactInEmailsBlackList({required String email}) async {
    await _put(
      path: '/contacts/$email',
      body: {
        'emailBlacklisted': true,
      },
    );
  }

  @override
  Future<void> removeContactFromEmailsBlackList({required String email}) async {
    await _put(
      path: '/contacts/$email',
      body: {
        'emailBlacklisted': false,
      },
    );
  }

  @override
  Future<void> updateContactProperties({
    required String email,
    required Map<String, dynamic> properties,
  }) async {
    await _put(
      path: '/contacts/$email',
      body: {
        'attributes': properties,
      },
    );
  }

  Future<void> _delete({required String path}) async {
    await http.delete(
      Uri.parse('$_baseUrl$path'),
      headers: _buildHeaders(),
    );
  }

  Future<Map<String, dynamic>> _post(
      {required String path, required Map<String, dynamic> body}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$path'),
      headers: _buildHeaders(),
      body: jsonEncode(body),
    );

    _throwIfError(response);

    if (response.body.isEmpty) {
      return {};
    }
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> _get<T>({required String path}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl$path'),
        headers: _buildHeaders(),
      );

      _throwIfError(response);
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _put<T>(
      {required String path, required Map<String, dynamic> body}) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl$path'),
        headers: _buildHeaders(),
        body: jsonEncode(body),
      );

      _throwIfError(response);

      if (response.body.isEmpty) {
        return {};
      }

      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  void _throwIfError(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) return;
    throw SendinblueApiException(response.statusCode, response.body);
  }

  Map<String, String> _buildHeaders() {
    return {
      'accept': 'application/json',
      'api-key': apiKey,
      'Content-Type': 'application/json',
    };
  }
}
