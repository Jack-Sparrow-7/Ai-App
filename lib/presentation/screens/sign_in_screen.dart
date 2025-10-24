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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with WidgetsBindingObserver, IOSKeyboardInsetUtil {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final signInFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toSignUp() {
    FocusManager.instance.primaryFocus?.unfocus();
    signInFormKey.currentState?.reset();
    context.go('/signUp');
  }

  void toForgotPassword() {
    FocusManager.instance.primaryFocus?.unfocus();
    signInFormKey.currentState?.reset();
    context.go('/forgotPassword');
  }

  void onSignIn() {
    if (signInFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      context.read<AuthBloc>().add(
        SignInRequested(email: email, password: password),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        // resizeToAvoidBottomInset: kIsWeb ? false : true,
        appBar: const AuthAppBar(appBarTitle: "Sign In"),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              SnackBarUtils.show(context, message: state.errorMessage);
            }
            if (state is Authenticated) {
              SnackBarUtils.show(context, message: "Sign In Successful");
              context.go('/home');
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
                      key: signInFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AuthHeader(
                            text: "You’re home — ready to\nshare again?",
                          ),
                          const Gap(40),
                          AuthField(
                            hintText: "Enter your email",
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            inputType: TextInputType.emailAddress,
                            labelText: "Email",
                          ),
                          const Gap(16),
                          AuthField(
                            hintText: "Enter your password",
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            labelText: "Password",
                            isPassword: true,
                            onEditingComplete: onSignIn,
                          ),
                          const Gap(8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: toForgotPassword,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                splashFactory: NoSplash.splashFactory,
                                overlayColor: Colors.transparent,
                              ),
                              child: Text(
                                "Forgot Password?",
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ),
                          const Gap(40),
                          AuthSubmitButton(
                            label: "Sign In",
                            onPressed: onSignIn,
                          ),
                          const Gap(40),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: Colors.transparent,
                            ),
                            onPressed: toSignUp,
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.grey,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ],
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
