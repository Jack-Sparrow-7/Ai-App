import 'package:ai_app/domain/repositories/auth_repository.dart';

class ForgotPasswordUsecase {
  final AuthRepository _authRepository;

  ForgotPasswordUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;
  Future<void> call({required String email}) async {
    return _authRepository.forgotPassword(email: email);
  }
}
