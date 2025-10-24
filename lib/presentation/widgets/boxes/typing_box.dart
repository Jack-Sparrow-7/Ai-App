import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/services/screen_utils.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class TypingBox extends StatelessWidget {
  const TypingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: context.w(72)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.stroke, width: 2),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.secondary,
        ),
        child: SelectableText("Lumi is Typing..", style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
