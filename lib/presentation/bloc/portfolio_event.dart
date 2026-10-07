import 'package:equatable/equatable.dart';
import '../../domain/entities/skill.dart';

sealed class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPortfolio extends PortfolioEvent {
  const LoadPortfolio();
}

final class SelectSkillCategory extends PortfolioEvent {
  final SkillCategoryType categoryType;

  const SelectSkillCategory(this.categoryType);

  @override
  List<Object?> get props => [categoryType];
}

final class SelectExperience extends PortfolioEvent {
  final int index;

  const SelectExperience(this.index);

  @override
  List<Object?> get props => [index];
}

final class SelectProject extends PortfolioEvent {
  final int index;

  const SelectProject(this.index);

  @override
  List<Object?> get props => [index];
}
