import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/skill.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({
    super.key,
    this.onViewProjects,
  });

  final VoidCallback? onViewProjects;

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _categoryColor(SkillCategoryType categoryType) {
    switch (categoryType) {
      case SkillCategoryType.flutter:
        return const Color(0xFF1677FF);
      case SkillCategoryType.android:
        return const Color(0xFF16A085);
      case SkillCategoryType.ai:
        return const Color(0xFF7C5CFC);
    }
  }

  IconData _categoryIcon(SkillCategoryType categoryType) {
    switch (categoryType) {
      case SkillCategoryType.flutter:
        return Icons.flutter_dash;
      case SkillCategoryType.android:
        return Icons.android;
      case SkillCategoryType.ai:
        return Icons.auto_awesome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (state is! PortfolioLoaded) {
          return const SizedBox.shrink();
        }

        final selectedType = state.selectedSkillCategory;
        final categories = state.portfolioData.skillCategories;
        final allSkills = state.portfolioData.skills;

        final currentCategory = categories.firstWhere(
          (c) => c.type == selectedType,
          orElse: () => categories.first,
        );

        final categorySkills =
            allSkills.where((s) => s.categoryType == selectedType).toList();

        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isMobile = constraints.maxWidth < 900;

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 70,
                    vertical: isMobile ? 60 : 100,
                  ),
                  child: isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIntroduction(
                              categories: categories,
                              selectedType: selectedType,
                            ),
                            const SizedBox(height: 40),
                            _buildTechnologyPanel(
                              category: currentCategory,
                              skills: categorySkills,
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: _buildIntroduction(
                                categories: categories,
                                selectedType: selectedType,
                              ),
                            ),
                            const SizedBox(width: 70),
                            Expanded(
                              flex: 6,
                              child: _buildTechnologyPanel(
                                category: currentCategory,
                                skills: categorySkills,
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildIntroduction({
    required List<SkillCategoryEntity> categories,
    required SkillCategoryType selectedType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '02 / SKILLS',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
            color: Color(0xFF1677FF),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Skills &\nTechnologies',
          style: TextStyle(
            fontSize: 48,
            height: 1.05,
            fontWeight: FontWeight.w700,
            color: Color(0xFF101828),
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'A practical stack built through years of mobile application development, from native Android engineering to modern Flutter development.',
          style: TextStyle(
            fontSize: 16,
            height: 1.7,
            color: Color(0xFF667085),
          ),
        ),
        const SizedBox(height: 35),
        _buildCategorySelector(
          categories: categories,
          selectedType: selectedType,
        ),
        if (widget.onViewProjects != null) ...[
          const SizedBox(height: 35),
          _buildProjectsButton(),
        ],
      ],
    );
  }

  Widget _buildCategorySelector({
    required List<SkillCategoryEntity> categories,
    required SkillCategoryType selectedType,
  }) {
    return Column(
      children: List.generate(categories.length, (index) {
        final category = categories[index];
        final number = '0${index + 1}';
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _buildCategoryButton(
            category: category,
            number: number,
            selected: category.type == selectedType,
          ),
        );
      }),
    );
  }

  Widget _buildCategoryButton({
    required SkillCategoryEntity category,
    required String number,
    required bool selected,
  }) {
    final Color color = _categoryColor(category.type);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context
              .read<PortfolioBloc>()
              .add(SelectSkillCategory(category.type));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: selected ? color.withValues(alpha: 0.06) : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: selected ? color : const Color(0xFFE4E7EC),
                width: selected ? 3 : 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: selected ? color : const Color(0xFF98A2B3),
                ),
              ),
              const SizedBox(width: 15),
              Icon(
                _categoryIcon(category.type),
                size: 20,
                color: selected ? color : const Color(0xFF98A2B3),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? const Color(0xFF101828)
                        : const Color(0xFF667085),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: selected ? 1 : 0,
                child: Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onViewProjects,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF101828),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View My Projects',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_forward,
                size: 17,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechnologyPanel({
    required SkillCategoryEntity category,
    required List<Skill> skills,
  }) {
    final featured = skills.where((s) => s.isFeatured).toList();
    final secondary = skills.where((s) => !s.isFeatured).toList();
    final Color color = _categoryColor(category.type);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final slide = Tween<Offset>(
          begin: const Offset(0.035, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
        );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slide,
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey(category.type),
        width: double.infinity,
        padding: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE4E7EC),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A101828),
              blurRadius: 30,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPanelHeader(
              category: category,
              color: color,
              totalSkills: skills.length,
            ),
            const SizedBox(height: 30),
            Text(
              category.description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.65,
                color: Color(0xFF667085),
              ),
            ),
            const SizedBox(height: 35),
            Text(
              'CORE STACK',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.8,
                color: color,
              ),
            ),
            const SizedBox(height: 18),
            _buildFeaturedSkills(featured, color),
            if (secondary.isNotEmpty) ...[
              const SizedBox(height: 35),
              Container(
                height: 1,
                color: const Color(0xFFEAECF0),
              ),
              const SizedBox(height: 30),
              const Text(
                'ALSO WORKED WITH',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                  color: Color(0xFF98A2B3),
                ),
              ),
              const SizedBox(height: 18),
              _buildSecondarySkills(secondary, color),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPanelHeader({
    required SkillCategoryEntity category,
    required Color color,
    required int totalSkills,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _categoryIcon(category.type),
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$totalSkills technologies',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF98A2B3),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'STACK',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSkills(List<Skill> skills, Color color) {
    return Column(
      children: List.generate(skills.length, (index) {
        final skill = skills[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101828),
                      ),
                    ),
                    if (skill.description != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        skill.description!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF98A2B3),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSecondarySkills(List<Skill> skills, Color color) {
    return Wrap(
      spacing: 9,
      runSpacing: 10,
      children: skills.map((skill) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: const Color(0xFFE4E7EC),
            ),
          ),
          child: Text(
            skill.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF475467),
            ),
          ),
        );
      }).toList(),
    );
  }
}
