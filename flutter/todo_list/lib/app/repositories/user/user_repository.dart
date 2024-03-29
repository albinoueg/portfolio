import 'package:firebase_auth/firebase_auth.dart';

abstract interface class UserRepository {
  Future<User?> register(String email, String password);
  Future<User?> login(String email, String password);
  Future<void> forgotPassord(String email);
  Future<User?> loginGoogle();
  Future<void> logout();
  Future<void> updateDisplayName(String name);
}