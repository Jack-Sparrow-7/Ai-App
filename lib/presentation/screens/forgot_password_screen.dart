import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/mixins/ios_keyboard_inset_util.dart';
import 'package:ai_app/core/services/screen_utils.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:ai_app/core/utils/snack_bar_utils.dart';
import 'package:ai_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:ai_app/presentation/widgets/app_bars/auth_app_bar.dart';
import 'package:ai_app/presentation/widgets/backgrounds/gradient_background.dart';
import 'package:ai_app/presentation/widgets/buttons/auth_submit_button.dart';
import 'package:ai_app/presentation/widgets/headers/auth_header.dart';
import 'package:ai_app/presentation/widgets/indicators/loading_indicator.dart';
import 'package:ai_app/presentation/widgets/text_fields/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with WidgetsBindingObserver, IOSKeyboardInsetUtil {
  final emailController = TextEditingController();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void toSignIn() {
    FocusManager.instance.primaryFocus?.unfocus();
    emailController.clearComposing();
    forgotPasswordFormKey.currentState?.reset();
    context.go('/signIn');
  }

  void onSubmit() {
    if (forgotPasswordFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      final email = emailController.text.trim();
      context.read<AuthBloc>().add(ForgotPasswordRequested(email: email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        // resizeToAvoidBottomInset: kIsWeb ? false : true,
        appBar: const AuthAppBar(appBarTitle: "Forgot Password"),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              SnackBarUtils.show(context, message: state.errorMessage);
            }
            if (state is AuthSuccess) {
              SnackBarUtils.show(
                context,
                message: "Password reset email sent!",
              );
              context.go('/signIn');
            }
          },
          builder: (context, state) {
            if (state is UnAuthenticated) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.isMobile ? double.infinity : 400,
                    ),
                    child: Form(
                      key: forgotPasswordFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AuthHeader(
                            text: "It's okay — every door\nhas a spare key.",
                          ),
                          const Gap(40),
                          AuthField(
                            hintText: "Enter your email",
                            controller: emailController,
                            textInputAction: TextInputAction.done,
                            inputType: TextInputType.emailAddress,
                            labelText: "Email",
                            onEditingComplete: onSubmit,
                          ),
                          const Gap(40),
                          AuthSubmitButton(
                            label: "Submit",
                            onPressed: onSubmit,
                          ),
                          const Gap(40),
                          TextButton(
                            onPressed: toSignIn,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: Colors.transparent,
                            ),
                            child: Text(
                              "Back to Sign In",
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const LoadingIndicator();
          },
        ),
      ),
    );
  }
}
