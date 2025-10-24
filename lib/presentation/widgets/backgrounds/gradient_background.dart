import 'dart:ui';

import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/services/screen_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: kIsWeb
          ? null
          : () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.background,
        child: Stack(
          children: [
            Positioned(
              top: 1,
              right: -50,
              child: Stack(
                children: [
                  Container(
                    width: context.w(80),
                    height: context.w(80),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryDark,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        width: context.w(80),
                        height: context.w(80),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: AppColors.background.withValues(alpha: .05),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Your content
            ?child,
          ],
        ),
      ),
    );
  }
}
