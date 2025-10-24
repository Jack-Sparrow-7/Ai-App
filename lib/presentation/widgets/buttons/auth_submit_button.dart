import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 4,
            spreadRadius: 3,
            color: AppColors.stroke,
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        color: AppColors.primary,
        minWidth: double.infinity,
        height: 56,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
