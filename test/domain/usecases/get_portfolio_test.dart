import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_portfolio_clean_architecture/data/repositories/portfolio_repository_impl.dart';
import 'package:flutter_portfolio_clean_architecture/domain/usecases/get_portfolio.dart';

void main() {
  test('GetPortfolio usecase returns portfolio data from repository', () async {
    final repository = PortfolioRepositoryImpl();
    final useCase = GetPortfolio(repository);

    final data = await useCase();

    expect(data.profile.name, equals('Your Name'));
    expect(data.experiences, isNotEmpty);
    expect(data.projects, isNotEmpty);
    expect(data.skills, isNotEmpty);
    expect(data.skillCategories, isNotEmpty);
  });
}
