import 'package:ai_app/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class MenuActionButton extends StatelessWidget {
  const MenuActionButton({super.key, required this.menuItems});
  final List<PopupMenuItem<dynamic>> menuItems;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      menuPadding: const EdgeInsets.all(8),
      color: AppColors.secondary,
      offset: Offset(0, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withValues(alpha: .1), width: 2),
      ),
      icon: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: .1),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: .4),
              width: 2,
            ),
            left: BorderSide(
              color: Colors.white.withValues(alpha: .4),
              width: 2,
            ),
            right: BorderSide(
              color: Colors.white.withValues(alpha: .4),
              width: 2,
            ),
          ),
        ),
        child: const Icon(Icons.menu),
      ),
      itemBuilder: (context) => menuItems,
    );
  }
}
