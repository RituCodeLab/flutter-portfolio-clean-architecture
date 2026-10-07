import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionLabel extends StatelessWidget {
  final String number;
  final String label;

  const SectionLabel({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.cyan,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          '$number  /  $label',
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
      ],
    );
  }
}
