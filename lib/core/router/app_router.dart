import 'package:ai_app/core/utils/auth_check.dart';
import 'package:ai_app/presentation/screens/forgot_password_screen.dart';
import 'package:ai_app/presentation/screens/home_screen.dart';
import 'package:ai_app/presentation/screens/page_not_found_screen.dart';
import 'package:ai_app/presentation/screens/sign_in_screen.dart';
import 'package:ai_app/presentation/screens/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => const PageNotFoundScreen(),
    redirect: (context, state) {
      final isAuthenticated = AuthCheck.isAuthenticated();

      final String location = state.matchedLocation;
      final protectedRoutes = ['/home'];
      final authRoutes = ['/','/signIn', '/signUp', '/forgotPassword'];

      if (isAuthenticated && authRoutes.contains(location)) {
        return '/home';
      }

      if (!isAuthenticated && protectedRoutes.contains(location)) {
        return '/signIn';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SignInScreen()),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/signIn',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );
}
