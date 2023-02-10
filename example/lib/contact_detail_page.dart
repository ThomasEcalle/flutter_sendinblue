import 'package:flutter/material.dart';
import 'package:flutter_sendinblue/flutter_sendinblue.dart';

class ContactDetailPage extends StatefulWidget {
  static void navigateTo(BuildContext context, String email) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactDetailPage(email: email),
      ),
    );
  }

  final String email;

  const ContactDetailPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  bool _isBlackListingLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.email),
      ),
      body: FutureBuilder<Contact>(
        future: Sendinblue.instance.getContact(email: widget.email),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error while getting the contact: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            final contact = snapshot.data;
            if (contact == null) {
              return const Center(
                child: Text('Contact not found'),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOptinSwitcher(context, contact),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _showContactAttributes(context, contact),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildOptinSwitcher(BuildContext context, Contact contact) {
    Widget switcher = Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: contact.emailBlackListed ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
    );

    if (_isBlackListingLoading) {
      switcher = const SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _toggleOptin(contact),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text('Optin', style: Theme.of(context).textTheme.headline6),
                const Spacer(),
                switcher,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showContactAttributes(BuildContext context, Contact contact) {
    final properties = contact.attributes;
    List<Text> propertyWidgets = [];

    if (properties.isEmpty) {
      propertyWidgets.add(const Text('No attributes found'));
    }

    properties.forEach((key, value) {
      propertyWidgets.add(Text('$key: $value'));
    });

    return ListView(
      children: propertyWidgets,
    );
  }

  void _toggleOptin(Contact contact) async {
    setState(() {
      _isBlackListingLoading = true;
    });

    if (contact.emailBlackListed) {
      await Sendinblue.instance.removeContactFromEmailsBlackList(email: contact.email);
    } else {
      await Sendinblue.instance.addContactInEmailsBlackList(email: contact.email);
    }

    setState(() {
      _isBlackListingLoading = false;
    });
  }
}
