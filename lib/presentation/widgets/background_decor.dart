import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BackgroundDecor extends StatelessWidget {
  const BackgroundDecor({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            left: -100,
            top: -120,
            child: _blob(const Color(0xFF9FEFFF), 250),
          ),
          Positioned(
            right: -120,
            top: 40,
            child: _blob(const Color(0xFFBBD6FF), 250),
          ),
          Positioned(
            right: -90,
            bottom: -110,
            child: _blob(AppColors.cyan, 230),
          ),
        ],
      ),
    );
  }

  Widget _blob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.32), color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}
