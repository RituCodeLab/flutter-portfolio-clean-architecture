import 'package:equatable/equatable.dart';
import '../../domain/entities/portfolio_entities.dart';

sealed class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

final class PortfolioInitial extends PortfolioState {
  const PortfolioInitial();
}

final class PortfolioLoading extends PortfolioState {
  const PortfolioLoading();
}

final class PortfolioLoaded extends PortfolioState {
  final PortfolioData portfolioData;
  final SkillCategoryType selectedSkillCategory;
  final int selectedExperienceIndex;
  final int selectedProjectIndex;

  const PortfolioLoaded({
    required this.portfolioData,
    this.selectedSkillCategory = SkillCategoryType.flutter,
    this.selectedExperienceIndex = 0,
    this.selectedProjectIndex = 0,
  });

  PortfolioLoaded copyWith({
    PortfolioData? portfolioData,
    SkillCategoryType? selectedSkillCategory,
    int? selectedExperienceIndex,
    int? selectedProjectIndex,
  }) {
    return PortfolioLoaded(
      portfolioData: portfolioData ?? this.portfolioData,
      selectedSkillCategory:
          selectedSkillCategory ?? this.selectedSkillCategory,
      selectedExperienceIndex:
          selectedExperienceIndex ?? this.selectedExperienceIndex,
      selectedProjectIndex:
          selectedProjectIndex ?? this.selectedProjectIndex,
    );
  }

  @override
  List<Object?> get props => [
        portfolioData,
        selectedSkillCategory,
        selectedExperienceIndex,
        selectedProjectIndex,
      ];
}

final class PortfolioFailure extends PortfolioState {
  final String message;

  const PortfolioFailure(this.message);

  @override
  List<Object?> get props => [message];
}
