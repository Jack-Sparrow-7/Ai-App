import 'package:ai_app/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:ai_app/domain/usecases/auth/log_out_usecase.dart';
import 'package:ai_app/domain/usecases/auth/sign_in_usecase.dart';
import 'package:ai_app/domain/usecases/auth/sign_up_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;
  final LogOutUsecase _logOutUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;

  AuthBloc(
    this._signInUsecase,
    this._signUpUsecase,
    this._logOutUsecase,
    this._forgotPasswordUsecase,
  ) : super(UnAuthenticated()) {
    String extractErrorMessage(dynamic error) {
      return error.toString().replaceFirst('Exception: ', '');
    }

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _signInUsecase(
          email: event.email,
          password: event.password,
        );
        emit(Authenticated(user: user));
      } catch (e) {
        emit(AuthError(errorMessage: extractErrorMessage(e)));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _signUpUsecase(
          email: event.email,
          password: event.password,
        );
        emit(Authenticated(user: user));
      } catch (e) {
        emit(AuthError(errorMessage: extractErrorMessage(e)));
        emit(UnAuthenticated());
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _logOutUsecase.call();
        emit(AuthSuccess());
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(errorMessage: extractErrorMessage(e)));
        emit(UnAuthenticated());
      }
    });

    on<ForgotPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _forgotPasswordUsecase.call(email: event.email);
        emit(AuthSuccess());
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(errorMessage: extractErrorMessage(e)));
        emit(UnAuthenticated());
      }
    });
  }
}
