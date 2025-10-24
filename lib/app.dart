import 'package:ai_app/core/di/injection.dart';
import 'package:ai_app/core/router/app_router.dart';
import 'package:ai_app/core/themes/app_theme.dart';
import 'package:ai_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:ai_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<ChatBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: AppTheme.darkTheme,
      ),
    );
  }
}
