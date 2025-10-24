part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthLoading extends AuthState{}

final class Authenticated extends AuthState {
  final User? user;

  Authenticated({required this.user});
}

final class UnAuthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String errorMessage;

  AuthError({required this.errorMessage});
}

final class AuthSuccess extends AuthState{}
