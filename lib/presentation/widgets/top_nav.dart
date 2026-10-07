import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/cv_downloader.dart';
import '../../domain/entities/portfolio_profile.dart';

class TopNav extends StatelessWidget {
  final PortfolioProfile profile;
  final VoidCallback onHome;
  final VoidCallback onSkills;
  final VoidCallback onExperience;
  final VoidCallback onProject;
  final VoidCallback onContactUs;

  const TopNav({
    super.key,
    required this.profile,
    required this.onHome,
    required this.onSkills,
    required this.onExperience,
    required this.onProject,
    required this.onContactUs,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 720;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.88),
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D0B5FFF),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              const Text(
                'RN',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  profile.name.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              if (!compact) ...[
                _NavButton(label: 'Home', onTap: onHome, active: true),
                _NavButton(label: 'Skills', onTap: onSkills),
                _NavButton(label: 'Experience', onTap: onExperience),
                _NavButton(label: 'Project', onTap: onProject),
                _NavButton(label: 'Contact', onTap: onContactUs),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: profile.cvUrl.isEmpty
                      ? null
                      : () => CvDownloader.downloadCv(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.blue,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    side: const BorderSide(
                      color: AppColors.blue,
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(
                    Icons.download_rounded,
                    size: 18,
                    color: AppColors.blue,
                  ),
                  label: const Text(
                    'Download CV',
                    style: TextStyle(
                      color: AppColors.blue,
                    ),
                  ),
                ),
              ] else ...[
                IconButton(
                  onPressed: onHome,
                  tooltip: 'Home',
                  icon: const Icon(Icons.home_outlined),
                ),
                IconButton(
                  onPressed: onSkills,
                  tooltip: 'Skills',
                  icon: const Icon(Icons.auto_awesome_outlined),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool active;

  const _NavButton({
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor:
            active ? AppColors.blue.withValues(alpha: 0.2) : Colors.transparent,
        foregroundColor: AppColors.navy,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
