import 'package:equatable/equatable.dart';

enum SkillCategoryType {
  flutter,
  android,
  ai,
}

class SkillCategoryEntity extends Equatable {
  final String id;
  final SkillCategoryType type;
  final String title;
  final String subtitle;
  final String description;

  const SkillCategoryEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  List<Object?> get props => [id, type, title, subtitle, description];
}

class Skill extends Equatable {
  final String id;
  final String name;
  final SkillCategoryType categoryType;
  final bool isFeatured;
  final String? description;

  const Skill({
    required this.id,
    required this.name,
    required this.categoryType,
    this.isFeatured = false,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, categoryType, isFeatured, description];
}
