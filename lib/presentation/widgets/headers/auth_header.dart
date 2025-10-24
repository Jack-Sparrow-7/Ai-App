import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(24),
        SelectableText(
          text,
          style: AppTextStyles.displayLarge.copyWith(
            color: Colors.white.withValues(alpha: .8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
