import 'package:ai_app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUsecase {
  final AuthRepository _authRepository;

  SignUpUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;
  Future<User?> call({required String email, required String password}) async {
    return await _authRepository.signUp(email: email, password: password);
  }
}
