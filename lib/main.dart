import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/portfolio_repository_impl.dart';
import 'domain/usecases/get_portfolio.dart';
import 'presentation/bloc/portfolio_bloc.dart';
import 'presentation/bloc/portfolio_event.dart';
import 'presentation/pages/portfolio_page.dart';

void main() {
  final repository = PortfolioRepositoryImpl();

  runApp(
    PortfolioApp(
      getPortfolio: GetPortfolio(repository),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  final GetPortfolio getPortfolio;

  const PortfolioApp({super.key, required this.getPortfolio});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ritu Nambath | Mobile Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: BlocProvider(
        create: (_) => PortfolioBloc(getPortfolio)..add(const LoadPortfolio()),
        child: const PortfolioPage(),
      ),
    );
  }
}
