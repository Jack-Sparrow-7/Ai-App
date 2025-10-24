import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class MessageField extends StatelessWidget {
  const MessageField({
    super.key,
    required TextEditingController controller,
    required VoidCallback onEditingComplete,
  }) : _controller = controller,
       _onEditingComplete = onEditingComplete;

  final TextEditingController _controller;
  final VoidCallback _onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(9999),
      borderSide: BorderSide.none,
    );
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: AppColors.secondary,

        border: Border(
          top: BorderSide(color: AppColors.stroke, width: 2),
          left: BorderSide(color: AppColors.stroke, width: 2),
          right: BorderSide(color: AppColors.stroke, width: 2),
          bottom: BorderSide.none, // No bottom border
        ),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: TextField(
        onEditingComplete: _onEditingComplete,
        controller: _controller,
        style: AppTextStyles.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: "Send Message",
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: .7),
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          contentPadding: const EdgeInsets.only(left: 16),
        ),
      ),
    );
  }
}
