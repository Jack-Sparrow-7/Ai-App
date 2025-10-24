import 'package:flutter/material.dart';

class SnackBarUtils {
  SnackBarUtils._();

  static void show(BuildContext context,{required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        showCloseIcon: true,
      ),
    );
  }
}
