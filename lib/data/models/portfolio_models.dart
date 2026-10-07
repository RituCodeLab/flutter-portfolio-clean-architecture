import '../../domain/entities/portfolio_entities.dart';

class PortfolioProfileModel {
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

  const PortfolioProfileModel({
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

  PortfolioProfile toEntity() {
    return PortfolioProfile(
      name: name,
      role: role,
      summary: summary,
      email: email,
      phone: phone,
      location: location,
      linkedIn: linkedIn,
      cvUrl: cvUrl,
      highlights: highlights,
      heroTechnologies: heroTechnologies,
    );
  }
}

class ExperienceModel {
  final String id;
  final String company;
  final String role;
  final String period;
  final String location;
  final String description;
  final List<String> technologies;
  final bool isCurrent;

  const ExperienceModel({
    required this.id,
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.description,
    required this.technologies,
    this.isCurrent = false,
  });

  Experience toEntity() {
    return Experience(
      id: id,
      company: company,
      role: role,
      period: period,
      location: location,
      description: description,
      technologies: technologies,
      isCurrent: isCurrent,
    );
  }
}

class ProjectModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final List<String> technologies;
  final bool isHighlighted;
  final List<String> details;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.technologies,
    this.isHighlighted = false,
    this.details = const [],
  });

  Project toEntity() {
    return Project(
      id: id,
      name: name,
      category: category,
      description: description,
      technologies: technologies,
      isHighlighted: isHighlighted,
      details: details,
    );
  }
}

class SkillCategoryModel {
  final String id;
  final String typeString;
  final String title;
  final String subtitle;
  final String description;

  const SkillCategoryModel({
    required this.id,
    required this.typeString,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  SkillCategoryEntity toEntity() {
    SkillCategoryType type;
    switch (typeString) {
      case 'android':
        type = SkillCategoryType.android;
        break;
      case 'ai':
        type = SkillCategoryType.ai;
        break;
      case 'flutter':
      default:
        type = SkillCategoryType.flutter;
        break;
    }
    return SkillCategoryEntity(
      id: id,
      type: type,
      title: title,
      subtitle: subtitle,
      description: description,
    );
  }
}

class SkillModel {
  final String id;
  final String name;
  final String categoryTypeString;
  final bool isFeatured;
  final String? description;

  const SkillModel({
    required this.id,
    required this.name,
    required this.categoryTypeString,
    this.isFeatured = false,
    this.description,
  });

  Skill toEntity() {
    SkillCategoryType type;
    switch (categoryTypeString) {
      case 'android':
        type = SkillCategoryType.android;
        break;
      case 'ai':
        type = SkillCategoryType.ai;
        break;
      case 'flutter':
      default:
        type = SkillCategoryType.flutter;
        break;
    }
    return Skill(
      id: id,
      name: name,
      categoryType: type,
      isFeatured: isFeatured,
      description: description,
    );
  }
}

class ContactItemModel {
  final String label;
  final String value;
  final String typeString;

  const ContactItemModel({
    required this.label,
    required this.value,
    required this.typeString,
  });

  ContactItemEntity toEntity() {
    ContactType type;
    switch (typeString) {
      case 'phone':
        type = ContactType.phone;
        break;
      case 'linkedin':
        type = ContactType.linkedin;
        break;
      case 'email':
      default:
        type = ContactType.email;
        break;
    }
    return ContactItemEntity(
      label: label,
      value: value,
      type: type,
    );
  }
}

class ContactInfoModel {
  final String email;
  final String phone;
  final String linkedIn;
  final String location;
  final String focus;
  final String workingWith;
  final List<ContactItemModel> contactItems;

  const ContactInfoModel({
    required this.email,
    required this.phone,
    required this.linkedIn,
    required this.location,
    required this.focus,
    required this.workingWith,
    required this.contactItems,
  });

  ContactInfo toEntity() {
    return ContactInfo(
      email: email,
      phone: phone,
      linkedIn: linkedIn,
      location: location,
      focus: focus,
      workingWith: workingWith,
      contactItems: contactItems.map((item) => item.toEntity()).toList(),
    );
  }
}

class PortfolioDataModel {
  final PortfolioProfileModel profile;
  final List<ExperienceModel> experiences;
  final List<ProjectModel> projects;
  final List<SkillCategoryModel> skillCategories;
  final List<SkillModel> skills;
  final ContactInfoModel contactInfo;

  const PortfolioDataModel({
    required this.profile,
    required this.experiences,
    required this.projects,
    required this.skillCategories,
    required this.skills,
    required this.contactInfo,
  });

  PortfolioData toEntity() {
    return PortfolioData(
      profile: profile.toEntity(),
      experiences: experiences.map((e) => e.toEntity()).toList(),
      projects: projects.map((p) => p.toEntity()).toList(),
      skillCategories: skillCategories.map((c) => c.toEntity()).toList(),
      skills: skills.map((s) => s.toEntity()).toList(),
      contactInfo: contactInfo.toEntity(),
    );
  }
}
