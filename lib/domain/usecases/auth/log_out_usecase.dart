import 'package:ai_app/domain/repositories/auth_repository.dart';

class LogOutUsecase {
  final AuthRepository _authRepository;

  LogOutUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;
  Future<void> call() async {
    return  _authRepository.logOut();
  }
}
