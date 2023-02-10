
This package provides a simple wrapper around the Sendinblue API.



> ⚠️ This package is **not an official package** from Sendinblue.

## Limitations

This package was initially built for a specific small project I was working for and was not intended to be an open source one.

Re-thinking about this, I thought that I should publish it to pub.dev anyway,  as it could help others.

That is why, for the moment, the number of functions is quite small (compared to what [the official API](https://developers.sendinblue.com/reference/) provides us)

Feel free to contribute or mention me if you need other wrappers.

## Features

- Contacts
- Create a contact
- Get all contacts
- Get contacts with pagination
- Get contact detail
- Delete a contact
- Add contact in emails black list
- Remove contact from emails black list
- Update contact properties

## Getting started

All you need to start playing with the API is to initialise the package with your API key like this :

```  
Sendinblue.initialize(  
 configuration: SendinblueConfiguration(apiKey: 'your-api-key'));  
```  
This initialisation can be done at any time but **must be done before any other call**.

## Usage

- Create a contact
```dart  
final int contactId = await Sendinblue.instance.createContact(email: 'hello@gmail.com');  
```  
- Get all contacts
```dart  
final List<Contact> contacts = await Sendinblue.instance.getAllContacts();
```  
- Get contacts with pagination
```dart  
final List<Contact> contacts = await Sendinblue.instance.getContacts(offset: 0, limit: 50);
```  
- Get a specific contact by email
```dart  
final Contact contact = await Sendinblue.instance.getContact(email: 'found@gmail.com');
```  
- Delete a contact by email
```dart
await Sendinblue.instance.deleteContact(email: 'delete@gmail.com');
```
- Add contact in email black list
```dart
await Sendinblue.instance.addUserInEmailsBlackList(email: 'blacklisted@gmail.com');
```
-  Remove contact of email black list
```dart
await Sendinblue.instance.removeContactFromEmailsBlackList(email: 'blacklisted@gmail.com');
```
- Update contact properties
```dart
await Sendinblue.instance.updateContactProperties(  
  email: 'updated@gmail.com',  
  properties: {  
    'name': 'John',  
    'premium': true,  
  },  
);
```
> Please note that the Sendinblue API will update properties only if they are already created on the platform (we coule also use the API but it is not implemented in this package for the moment)
>



## Additional information

For more information on what could be done with this package, here is the official Sendinblue document with all the APIs : https://developers.sendinblue.com/reference