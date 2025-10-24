import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NoMessagesBody extends StatelessWidget {
  const NoMessagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              "Hi, I'm Lumi Name.",
              style: AppTextStyles.displayLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            SelectableText(
              "What's on your mind\ntoday?",
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
