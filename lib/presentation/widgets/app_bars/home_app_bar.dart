import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.appBarTitle, this.actions});

  final String appBarTitle;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      centerTitle: true,
      scrolledUnderElevation: 0,
      titleTextStyle: AppTextStyles.headingLarge,
      actions: actions,
    );
  }
}
