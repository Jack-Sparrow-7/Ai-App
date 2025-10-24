import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/services/screen_utils.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:ai_app/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: context.w(72)),
        decoration: BoxDecoration(
          border: isUser ? null : Border.all(color: AppColors.stroke, width: 2),
          borderRadius: BorderRadius.circular(16),
          color: isUser ? AppColors.primary : AppColors.secondary,
        ),
        child: SelectableText(message.text, style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
