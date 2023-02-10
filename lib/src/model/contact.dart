class Contact {
  final int id;
  final String email;
  final bool emailBlackListed;
  final bool smsBlackListed;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final Map<String, dynamic> attributes;

  const Contact({
    required this.id,
    required this.email,
    required this.emailBlackListed,
    required this.smsBlackListed,
    required this.createdAt,
    required this.modifiedAt,
    required this.attributes,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      email: json['email'],
      emailBlackListed: json['emailBlacklisted'],
      smsBlackListed: json['smsBlacklisted'],
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: DateTime.parse(json['modifiedAt']),
      attributes: json['attributes'],
    );
  }

  @override
  String toString() {
    return 'Contact(id: $id, email: $email, emailBlackListed: $emailBlackListed, attributes: $attributes)';
  }
}
