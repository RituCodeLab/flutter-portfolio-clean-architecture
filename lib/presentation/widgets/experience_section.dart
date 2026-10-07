import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/experience.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (state is! PortfolioLoaded) {
          return const SizedBox.shrink();
        }

        final experiences = state.portfolioData.experiences;
        final selectedIndex = state.selectedExperienceIndex;

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
                      ? _buildMobileLayout(
                          experiences: experiences,
                          selectedIndex: selectedIndex,
                        )
                      : _buildDesktopLayout(
                          experiences: experiences,
                          selectedIndex: selectedIndex,
                        ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout({
    required List<Experience> experiences,
    required int selectedIndex,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: _buildIntroduction(
            roleCount: experiences.length,
          ),
        ),
        const SizedBox(width: 70),
        Expanded(
          flex: 6,
          child: _buildExperienceList(
            experiences: experiences,
            selectedIndex: selectedIndex,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout({
    required List<Experience> experiences,
    required int selectedIndex,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIntroduction(
          roleCount: experiences.length,
        ),
        const SizedBox(height: 50),
        _buildExperienceList(
          experiences: experiences,
          selectedIndex: selectedIndex,
        ),
      ],
    );
  }

  Widget _buildIntroduction({required int roleCount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '03 / EXPERIENCE',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
            color: Color(0xFF1677FF),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Professional\nExperience',
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
          'A decade of building mobile applications across native Android and Flutter, from hands-on development to leading mobile engineering work.',
          style: TextStyle(
            fontSize: 16,
            height: 1.7,
            color: Color(0xFF667085),
          ),
        ),
        const SizedBox(height: 35),
        _buildExperienceStats(roleCount: roleCount),
      ],
    );
  }

  Widget _buildExperienceStats({required int roleCount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStat(
          value: '9+',
          label: 'Years in mobile development',
        ),
        const SizedBox(height: 22),
        _buildStat(
          value: '$roleCount',
          label: 'Professional roles',
        ),
        const SizedBox(height: 22),
        _buildStat(
          value: 'Android + Flutter',
          label: 'Primary development focus',
        ),
      ],
    );
  }

  Widget _buildStat({
    required String value,
    required String label,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF1677FF),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101828),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF98A2B3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceList({
    required List<Experience> experiences,
    required int selectedIndex,
  }) {
    return Column(
      children: List.generate(
        experiences.length,
        (index) {
          final experience = experiences[index];
          return _buildExperienceItem(
            experience: experience,
            index: index,
            selected: selectedIndex == index,
            isLast: index == experiences.length - 1,
          );
        },
      ),
    );
  }

  Widget _buildExperienceItem({
    required Experience experience,
    required int index,
    required bool selected,
    required bool isLast,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.read<PortfolioBloc>().add(SelectExperience(index));
        },
        child: Stack(
          children: [
            if (!isLast)
              Positioned(
                left: 8,
                top: 14,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: const Color(0xFFE4E7EC),
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 18,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: _buildTimelineDot(selected: selected),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildExperienceCard(
                    experience: experience,
                    index: index,
                    selected: selected,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineDot({required bool selected}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      width: selected ? 14 : 10,
      height: selected ? 14 : 10,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF1677FF) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? const Color(0xFF1677FF) : const Color(0xFF98A2B3),
          width: 2,
        ),
        boxShadow: selected
            ? const [
                BoxShadow(
                  color: Color(0x331677FF),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildExperienceCard({
    required Experience experience,
    required int index,
    required bool selected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: selected ? Colors.white : const Color(0xFFFCFCFD),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? const Color(0xFFB2DDFF) : const Color(0xFFEAECF0),
        ),
        boxShadow: selected
            ? const [
                BoxShadow(
                  color: Color(0x0D101828),
                  blurRadius: 25,
                  offset: Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(experience, selected),
          AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: selected
                ? _buildExpandedContent(experience)
                : _buildCollapsedContent(experience),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(Experience experience, bool selected) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      experience.company,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101828),
                      ),
                    ),
                  ),
                  if (experience.isCurrent) ...[
                    const SizedBox(width: 10),
                    _buildCurrentBadge(),
                  ],
                ],
              ),
              const SizedBox(height: 6),
              Text(
                experience.role,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? const Color(0xFF1677FF)
                      : const Color(0xFF667085),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        AnimatedRotation(
          turns: selected ? 0.125 : 0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: const Icon(
            Icons.add,
            size: 21,
            color: Color(0xFF98A2B3),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'CURRENT',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: Color(0xFF027A48),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent(Experience experience) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Wrap(
        spacing: 18,
        runSpacing: 8,
        children: [
          _buildInfoItem(
            icon: Icons.calendar_today_outlined,
            text: experience.period,
          ),
          _buildInfoItem(
            icon: Icons.location_on_outlined,
            text: experience.location,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(Experience experience) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            color: const Color(0xFFEAECF0),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 18,
            runSpacing: 8,
            children: [
              _buildInfoItem(
                icon: Icons.calendar_today_outlined,
                text: experience.period,
              ),
              _buildInfoItem(
                icon: Icons.location_on_outlined,
                text: experience.location,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            experience.description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.7,
              color: Color(0xFF667085),
            ),
          ),
          const SizedBox(height: 20),
          _buildTechnologyTags(experience.technologies),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: const Color(0xFF98A2B3),
        ),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF667085),
          ),
        ),
      ],
    );
  }

  Widget _buildTechnologyTags(List<String> technologies) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: technologies.map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFE4E7EC),
            ),
          ),
          child: Text(
            tech,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF475467),
            ),
          ),
        );
      }).toList(),
    );
  }
}
