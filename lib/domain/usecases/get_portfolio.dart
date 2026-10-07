import '../entities/portfolio_data.dart';
import '../repositories/portfolio_repository.dart';

class GetPortfolio {
  final PortfolioRepository repository;

  const GetPortfolio(this.repository);

  Future<PortfolioData> call() => repository.getPortfolioData();
}
