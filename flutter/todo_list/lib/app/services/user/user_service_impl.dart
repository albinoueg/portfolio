import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);

  @override
  Future<void> forgotPassord(String email) =>
      _userRepository.forgotPassord(email);

  @override
  Future<User?> loginGoogle() => _userRepository.loginGoogle();
  
  @override
  Future<void> logout() => _userRepository.logout();
  
  @override
  Future<void> updateDisplayName(String name) => _userRepository.updateDisplayName(name);
}
