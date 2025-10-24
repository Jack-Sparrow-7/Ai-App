import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    this.isPassword = false,
    required this.hintText,
    required this.controller,
    required this.textInputAction,
    required this.inputType,
    this.onEditingComplete,
    required this.labelText,
  });

  final bool isPassword;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType inputType;
  final VoidCallback? onEditingComplete;
  final String labelText;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  ValueNotifier<bool> isObsecure = ValueNotifier(true);

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return "This is a required field.";
    }

    if (!widget.isPassword &&
        !RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        ).hasMatch(value)) {
      return "Please enter a valid email.";
    }

    return null;
  }

  final border = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.stroke),
    borderRadius: BorderRadius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isObsecure,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SelectableText(
                widget.labelText,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(8),
            TextFormField(
              obscureText: widget.isPassword ? value : false,
              style: AppTextStyles.bodyMedium,
              controller: widget.controller,
              validator: (value) => _validateField(value),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: .8),
                ),
                filled: true,
                fillColor: AppColors.secondary,
                border: border,
                errorBorder: border,
                enabledBorder: border,
                focusedBorder: border,
                focusedErrorBorder: border,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        style: IconButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: Colors.transparent,
                        ),
                        onPressed: () => isObsecure.value = !value,
                        icon: Icon(
                          value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.white.withValues(alpha: .8),
                        ),
                      )
                    : null,
              ),
              onEditingComplete: widget.onEditingComplete,
              textInputAction: widget.textInputAction,
              keyboardType: widget.inputType,
              onTapOutside: (event) =>
                  kIsWeb ? FocusManager.instance.primaryFocus?.unfocus() : null,
              onTapUpOutside: (event) =>
                  kIsWeb ? FocusManager.instance.primaryFocus?.unfocus() : null,
            ),
          ],
        );
      },
    );
  }
}
