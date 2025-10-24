import 'package:ai_app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUsecase {
  final AuthRepository _authRepository;

  SignInUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;
  Future<User?> call({required String email, required String password}) async {
    return await _authRepository.signIn(email: email, password: password);
  }
}
