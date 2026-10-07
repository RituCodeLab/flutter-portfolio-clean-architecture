import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/project.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({
    super.key,
    this.onProjectSelected,
  });

  final ValueChanged<Project>? onProjectSelected;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
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

        final projects = state.portfolioData.projects;
        final selectedIndex = state.selectedProjectIndex;

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
                          projects: projects,
                          selectedIndex: selectedIndex,
                        )
                      : _buildDesktopLayout(
                          projects: projects,
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
    required List<Project> projects,
    required int selectedIndex,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: _buildIntroduction(
            projectCount: projects.length,
          ),
        ),
        const SizedBox(width: 70),
        Expanded(
          flex: 6,
          child: _buildProjectsList(
            projects: projects,
            selectedIndex: selectedIndex,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout({
    required List<Project> projects,
    required int selectedIndex,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIntroduction(
          projectCount: projects.length,
        ),
        const SizedBox(height: 45),
        _buildProjectsList(
          projects: projects,
          selectedIndex: selectedIndex,
        ),
      ],
    );
  }

  Widget _buildIntroduction({required int projectCount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '04 / PROJECTS',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
            color: Color(0xFF1677FF),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Selected\nProjects',
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
          'A selection of mobile applications I have worked on across healthcare, finance, health and consumer-focused products.',
          style: TextStyle(
            fontSize: 16,
            height: 1.7,
            color: Color(0xFF667085),
          ),
        ),
        const SizedBox(height: 35),
        _buildProjectStats(projectCount: projectCount),
        const SizedBox(height: 35),
        _buildProjectHint(),
      ],
    );
  }

  Widget _buildProjectStats({required int projectCount}) {
    return Row(
      children: [
        _buildStat(
          value: '$projectCount',
          label: 'Selected projects',
        ),
        const SizedBox(width: 35),
        _buildStat(
          value: '4+',
          label: 'Product domains',
        ),
      ],
    );
  }

  Widget _buildStat({
    required String value,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF101828),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF98A2B3),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectHint() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFEAECF0),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.touch_app_outlined,
            size: 20,
            color: Color(0xFF1677FF),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Select a project to explore the technology stack and development work.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF667085),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsList({
    required List<Project> projects,
    required int selectedIndex,
  }) {
    return Column(
      children: List.generate(
        projects.length,
        (index) {
          final project = projects[index];
          return _buildProjectCard(
            project: project,
            index: index,
            selected: selectedIndex == index,
          );
        },
      ),
    );
  }

  Widget _buildProjectCard({
    required Project project,
    required int index,
    required bool selected,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.read<PortfolioBloc>().add(SelectProject(index));
          widget.onProjectSelected?.call(project);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(selected ? 28 : 22),
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
                      blurRadius: 28,
                      offset: Offset(0, 12),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProjectHeader(
                project: project,
                selected: selected,
                index: index,
              ),
              const SizedBox(height: 14),
              AnimatedSize(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: selected
                    ? _buildExpandedProject(project)
                    : _buildCollapsedProject(project),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectHeader({
    required Project project,
    required bool selected,
    required int index,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProjectNumber(index, selected),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101828),
                      ),
                    ),
                  ),
                  if (project.isHighlighted) ...[
                    const SizedBox(width: 10),
                    _buildFeaturedBadge(),
                  ],
                ],
              ),
              const SizedBox(height: 5),
              Text(
                project.category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? const Color(0xFF1677FF)
                      : const Color(0xFF98A2B3),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        AnimatedRotation(
          turns: selected ? 0.125 : 0,
          duration: const Duration(milliseconds: 250),
          child: const Icon(
            Icons.add,
            size: 21,
            color: Color(0xFF98A2B3),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectNumber(int index, bool selected) {
    final number = (index + 1).toString().padLeft(2, '0');

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 42,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF1677FF) : const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        number,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
          color: selected ? Colors.white : const Color(0xFF98A2B3),
        ),
      ),
    );
  }

  Widget _buildFeaturedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'FEATURED',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: Color(0xFF1677FF),
        ),
      ),
    );
  }

  Widget _buildCollapsedProject(Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            height: 1.6,
            color: Color(0xFF667085),
          ),
        ),
        const SizedBox(height: 15),
        _buildTechnologyPreview(project.technologies),
      ],
    );
  }

  Widget _buildExpandedProject(Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: const Color(0xFFEAECF0),
        ),
        const SizedBox(height: 20),
        Text(
          project.description,
          style: const TextStyle(
            fontSize: 14,
            height: 1.7,
            color: Color(0xFF667085),
          ),
        ),
        if (project.details.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text(
            'DEVELOPMENT WORK',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
              color: Color(0xFF98A2B3),
            ),
          ),
          const SizedBox(height: 14),
          _buildProjectDetails(project.details),
        ],
        const SizedBox(height: 24),
        const Text(
          'TECHNOLOGY',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
            color: Color(0xFF98A2B3),
          ),
        ),
        const SizedBox(height: 14),
        _buildTechnologyTags(project.technologies),
      ],
    );
  }

  Widget _buildProjectDetails(List<String> details) {
    return Column(
      children: List.generate(details.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 7),
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Color(0xFF1677FF),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  details[index],
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF667085),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTechnologyPreview(List<String> technologies) {
    final visible = technologies.take(4).toList();

    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        ...visible.map((tech) => _buildTechnologyChip(tech)),
        if (technologies.length > 4)
          _buildMoreChip(technologies.length - 4),
      ],
    );
  }

  Widget _buildTechnologyTags(List<String> technologies) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: technologies.map((tech) => _buildTechnologyChip(tech)).toList(),
    );
  }

  Widget _buildTechnologyChip(String technology) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Text(
        technology,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF475467),
        ),
      ),
    );
  }

  Widget _buildMoreChip(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8FF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '+$count',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1677FF),
        ),
      ),
    );
  }
}
