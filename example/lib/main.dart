import 'package:flutter/material.dart';
import 'package:flutter_sendinblue/flutter_sendinblue.dart';

import 'contact_detail_page.dart';

void main() {
  Sendinblue.initialize(
    configuration: SendinblueConfiguration(
      apiKey:
          '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',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sendinblue Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sendinblue Demo'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: Sendinblue.instance.getAllContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final contacts = snapshot.data;
            if (contacts == null) {
              return const Center(
                child: Text('No contacts found'),
              );
            }
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = snapshot.data![index];
                return ListTile(
                  title: Text(
                    contact.email,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text('id: ${contact.id}'),
                  onTap: () =>
                      ContactDetailPage.navigateTo(context, contact.email),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
