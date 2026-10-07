import 'package:equatable/equatable.dart';

class PortfolioProfile extends Equatable {
  final String name;
  final String role;
  final String summary;
  final String email;
  final String phone;
  final String location;
  final String linkedIn;
  final String cvUrl;
  final List<String> highlights;
  final List<String> heroTechnologies;

  const PortfolioProfile({
    required this.name,
    required this.role,
    required this.summary,
    required this.email,
    required this.phone,
    required this.location,
    required this.linkedIn,
    required this.cvUrl,
    required this.highlights,
    required this.heroTechnologies,
  });

  @override
  List<Object?> get props => [
        name,
        role,
        summary,
        email,
        phone,
        location,
        linkedIn,
        cvUrl,
        highlights,
        heroTechnologies,
      ];
}
