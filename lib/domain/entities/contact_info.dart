import 'package:equatable/equatable.dart';

enum ContactType {
  email,
  phone,
  linkedin,
}

class ContactItemEntity extends Equatable {
  final String label;
  final String value;
  final ContactType type;

  const ContactItemEntity({
    required this.label,
    required this.value,
    required this.type,
  });

  @override
  List<Object?> get props => [label, value, type];
}

class ContactInfo extends Equatable {
  final String email;
  final String phone;
  final String linkedIn;
  final String location;
  final String focus;
  final String workingWith;
  final List<ContactItemEntity> contactItems;

  const ContactInfo({
    required this.email,
    required this.phone,
    required this.linkedIn,
    required this.location,
    required this.focus,
    required this.workingWith,
    required this.contactItems,
  });

  @override
  List<Object?> get props => [
        email,
        phone,
        linkedIn,
        location,
        focus,
        workingWith,
        contactItems,
      ];
}
