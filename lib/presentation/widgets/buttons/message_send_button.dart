import 'package:ai_app/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageSendButton extends StatelessWidget {
  const MessageSendButton({super.key, required this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: AppColors.stroke, blurRadius: 4, spreadRadius: 3),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: CircleBorder(),
          padding: EdgeInsets.only(left: 3),
        ),
        child: SvgPicture.asset('assets/svgs/send.svg'),
      ),
    );
  }
}
