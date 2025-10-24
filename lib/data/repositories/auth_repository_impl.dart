import 'package:ai_app/data/datasources/auth_datasource.dart';
import 'package:ai_app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl({required AuthDatasource authDatasource})
    : _authDatasource = authDatasource;

  @override
  Future<void> forgotPassword({required String email}) {
    return _authDatasource.forgotPassword(email: email);
  }

  @override
  Future<void> logOut() {
    return _authDatasource.logOut();
  }

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    return await _authDatasource.signIn(email: email, password: password);
  }

  @override
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    return await _authDatasource.signUp(email: email, password: password);
  }
}
