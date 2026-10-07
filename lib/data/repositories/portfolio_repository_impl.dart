import '../../domain/entities/portfolio_data.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  PortfolioRepositoryImpl({PortfolioLocalDataSource? localDataSource})
      : localDataSource = localDataSource ?? PortfolioLocalDataSourceImpl();

  @override
  Future<PortfolioData> getPortfolioData() async {
    final model = await localDataSource.getPortfolioData();
    return model.toEntity();
  }
}
