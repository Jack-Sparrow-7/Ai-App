import 'package:firebase_auth/firebase_auth.dart';

class AuthCheck {
  AuthCheck._();

  static bool isAuthenticated() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  static User? get currentUser => FirebaseAuth.instance.currentUser;
}
