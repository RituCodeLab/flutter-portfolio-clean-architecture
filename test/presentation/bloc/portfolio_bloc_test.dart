import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_portfolio_clean_architecture/data/repositories/portfolio_repository_impl.dart';
import 'package:flutter_portfolio_clean_architecture/domain/entities/skill.dart';
import 'package:flutter_portfolio_clean_architecture/domain/usecases/get_portfolio.dart';
import 'package:flutter_portfolio_clean_architecture/presentation/bloc/portfolio_bloc.dart';
import 'package:flutter_portfolio_clean_architecture/presentation/bloc/portfolio_event.dart';
import 'package:flutter_portfolio_clean_architecture/presentation/bloc/portfolio_state.dart';

void main() {
  late PortfolioBloc bloc;
  late GetPortfolio getPortfolio;

  setUp(() {
    final repository = PortfolioRepositoryImpl();
    getPortfolio = GetPortfolio(repository);
    bloc = PortfolioBloc(getPortfolio);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is PortfolioInitial', () {
    expect(bloc.state, equals(const PortfolioInitial()));
  });

  test('emits [PortfolioLoading, PortfolioLoaded] when LoadPortfolio is added', () async {
    final expectedStates = [
      const PortfolioLoading(),
      isA<PortfolioLoaded>(),
    ];

    expectLater(bloc.stream, emitsInOrder(expectedStates));

    bloc.add(const LoadPortfolio());
  });

  test('emits updated selectedSkillCategory when SelectSkillCategory is added', () async {
    bloc.add(const LoadPortfolio());
    await bloc.stream.firstWhere((s) => s is PortfolioLoaded);

    bloc.add(const SelectSkillCategory(SkillCategoryType.android));

    await expectLater(
      bloc.stream,
      emits(
        isA<PortfolioLoaded>().having(
          (s) => s.selectedSkillCategory,
          'selectedSkillCategory',
          SkillCategoryType.android,
        ),
      ),
    );
  });
}
