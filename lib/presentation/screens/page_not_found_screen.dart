import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:ai_app/presentation/widgets/backgrounds/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Page not Found!", style: AppTextStyles.bodyMedium),
              const Gap( 16),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () => context.go('/'),
                child: const Text("Go Home", style: AppTextStyles.bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
