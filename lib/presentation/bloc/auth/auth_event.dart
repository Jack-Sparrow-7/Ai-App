part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});
}

final class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});
}

final class ForgotPasswordRequested extends AuthEvent {

  final String email;

  ForgotPasswordRequested({required this.email});
}

final class LogoutRequested extends AuthEvent {}
