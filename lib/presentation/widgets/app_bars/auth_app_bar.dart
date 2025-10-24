import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key, required this.appBarTitle});

  final String appBarTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      centerTitle: true,
      scrolledUnderElevation: 0,
      titleTextStyle: AppTextStyles.headingLarge,
    );
  }
}
