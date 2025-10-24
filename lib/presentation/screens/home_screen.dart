import 'package:ai_app/core/colors/app_colors.dart';
import 'package:ai_app/core/text_styles/app_text_styles.dart';
import 'package:ai_app/core/utils/auth_check.dart';
import 'package:ai_app/core/utils/snack_bar_utils.dart';
import 'package:ai_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:ai_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:ai_app/presentation/bloc/chat/chat_state.dart';
import 'package:ai_app/presentation/widgets/app_bars/home_app_bar.dart';
import 'package:ai_app/presentation/widgets/backgrounds/gradient_background.dart';
import 'package:ai_app/presentation/widgets/bodies/messages_body.dart';
import 'package:ai_app/presentation/widgets/bodies/no_messages_body.dart';
import 'package:ai_app/presentation/widgets/buttons/menu_action_button.dart';
import 'package:ai_app/presentation/widgets/buttons/message_send_button.dart';
import 'package:ai_app/presentation/widgets/indicators/loading_indicator.dart';
import 'package:ai_app/presentation/widgets/text_fields/message_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = AuthCheck.currentUser;
    if (user != null) {
      context.read<ChatBloc>().add(LoadMessagesRequested(uid: user.uid));
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void onLogout() {
    context.read<AuthBloc>().add(LogoutRequested());
  }

  void onEraseData() {
    final user = AuthCheck.currentUser;
    context.read<ChatBloc>().add(EraseMessagesRequested(uid: user!.uid));
  }

  void onSendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      messageController.clear();
      final user = AuthCheck.currentUser;
      if (!mounted) return;
      context.read<ChatBloc>().add(
        SendMessageRequested(uid: user!.uid, text: text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          SnackBarUtils.show(context, message: "Logged out successfully");
          if (!mounted) return;
          context.go('/signIn');
        }
        if (state is AuthError) {
          SnackBarUtils.show(context, message: state.errorMessage);
        }
      },
      child: GradientBackground(
        child: Scaffold(
          // resizeToAvoidBottomInset: kIsWeb ? false : true,
          appBar: HomeAppBar(
            appBarTitle: "Home",
            actions: [
              MenuActionButton(
                menuItems: [
                  PopupMenuItem(
                    onTap: onEraseData,
                    child: Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete_outline, color: AppColors.red),
                        Text(
                          "Erase Data",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onLogout,
                    child: Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout_outlined),
                        Text("Log out", style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state.error != null) {
                SnackBarUtils.show(
                  context,
                  message: "Something went, Please try again!",
                );
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const LoadingIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state.messages.isEmpty) const NoMessagesBody(),
                  if (state.messages.isNotEmpty) MessagesBody(state: state),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 32,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: MessageField(
                              controller: messageController,
                              onEditingComplete: onSendMessage,
                            ),
                          ),
                          MessageSendButton(
                            onPressed: state.isTyping ? null : onSendMessage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
