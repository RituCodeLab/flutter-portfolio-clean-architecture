import 'package:equatable/equatable.dart';

class Experience extends Equatable {
  final String id;
  final String company;
  final String role;
  final String period;
  final String location;
  final String description;
  final List<String> technologies;
  final bool isCurrent;

  const Experience({
    required this.id,
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.description,
    required this.technologies,
    this.isCurrent = false,
  });

  @override
  List<Object?> get props => [
        id,
        company,
        role,
        period,
        location,
        description,
        technologies,
        isCurrent,
      ];
}
