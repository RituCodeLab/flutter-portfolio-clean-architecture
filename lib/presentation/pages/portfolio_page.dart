import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_state.dart';
import '../widgets/background_decor.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/portfolio_background.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/top_nav.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _homeKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _expKey = GlobalKey();
  final _projKey = GlobalKey();
  final _conKey = GlobalKey();

  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final targetContext = key.currentContext;

    if (targetContext == null) {
      return;
    }

    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      alignment: 0.04,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundDecor(),
          BlocBuilder<PortfolioBloc, PortfolioState>(
            builder: (context, state) {
              if (state is PortfolioLoading || state is PortfolioInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is PortfolioFailure) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is! PortfolioLoaded) {
                return const SizedBox.shrink();
              }

              final profile = state.portfolioData.profile;

              return PortfolioBackground(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      SafeArea(
                        bottom: false,
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1240),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                              child: TopNav(
                                profile: profile,
                                onHome: () => _scrollTo(_homeKey),
                                onSkills: () => _scrollTo(_skillsKey),
                                onExperience: () => _scrollTo(_expKey),
                                onProject: () => _scrollTo(_projKey),
                                onContactUs: () => _scrollTo(_conKey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1240),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                HeroSection(
                                  key: _homeKey,
                                  profile: profile,
                                  onSkills: () => _scrollTo(_skillsKey),
                                ),
                                const Divider(color: AppColors.border),
                                SkillsSection(
                                  key: _skillsKey,
                                  onViewProjects: () => _scrollTo(_projKey),
                                ),
                                const Divider(color: AppColors.border),
                                ExperienceSection(key: _expKey),
                                const Divider(color: AppColors.border),
                                ProjectsSection(key: _projKey),
                                const Divider(color: AppColors.border),
                                ContactSection(key: _conKey),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
