import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_portfolio.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolio getPortfolio;

  PortfolioBloc(this.getPortfolio) : super(const PortfolioInitial()) {
    on<LoadPortfolio>(_onLoadPortfolio);
    on<SelectSkillCategory>(_onSelectSkillCategory);
    on<SelectExperience>(_onSelectExperience);
    on<SelectProject>(_onSelectProject);
  }

  Future<void> _onLoadPortfolio(
    LoadPortfolio event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const PortfolioLoading());
    try {
      final portfolioData = await getPortfolio();
      emit(PortfolioLoaded(portfolioData: portfolioData));
    } catch (_) {
      emit(const PortfolioFailure('Unable to load portfolio data.'));
    }
  }

  void _onSelectSkillCategory(
    SelectSkillCategory event,
    Emitter<PortfolioState> emit,
  ) {
    if (state is PortfolioLoaded) {
      final current = state as PortfolioLoaded;
      emit(current.copyWith(selectedSkillCategory: event.categoryType));
    }
  }

  void _onSelectExperience(
    SelectExperience event,
    Emitter<PortfolioState> emit,
  ) {
    if (state is PortfolioLoaded) {
      final current = state as PortfolioLoaded;
      if (event.index >= 0 &&
          event.index < current.portfolioData.experiences.length) {
        emit(current.copyWith(selectedExperienceIndex: event.index));
      }
    }
  }

  void _onSelectProject(
    SelectProject event,
    Emitter<PortfolioState> emit,
  ) {
    if (state is PortfolioLoaded) {
      final current = state as PortfolioLoaded;
      if (event.index >= 0 &&
          event.index < current.portfolioData.projects.length) {
        emit(current.copyWith(selectedProjectIndex: event.index));
      }
    }
  }
}
