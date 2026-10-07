import 'package:equatable/equatable.dart';
import 'portfolio_profile.dart';
import 'experience.dart';
import 'project.dart';
import 'skill.dart';
import 'contact_info.dart';

class PortfolioData extends Equatable {
  final PortfolioProfile profile;
  final List<Experience> experiences;
  final List<Project> projects;
  final List<SkillCategoryEntity> skillCategories;
  final List<Skill> skills;
  final ContactInfo contactInfo;

  const PortfolioData({
    required this.profile,
    required this.experiences,
    required this.projects,
    required this.skillCategories,
    required this.skills,
    required this.contactInfo,
  });

  @override
  List<Object?> get props => [
        profile,
        experiences,
        projects,
        skillCategories,
        skills,
        contactInfo,
      ];
}
