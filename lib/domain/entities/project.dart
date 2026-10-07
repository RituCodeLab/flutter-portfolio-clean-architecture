import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String name;
  final String category;
  final String description;
  final List<String> technologies;
  final bool isHighlighted;
  final List<String> details;

  const Project({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.technologies,
    this.isHighlighted = false,
    this.details = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        description,
        technologies,
        isHighlighted,
        details,
      ];
}
