import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list/app/exception/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      /*if(e.code == 'email-already-in-use'){
        final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if(loginTypes.contains('password')){
          throw AuthException(message: 'E-mail já utilizado');
        }else{
          throw AuthException(message: 'Você já se cadastrou com o google!');
        }
      }else{
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }*/
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassord(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? 'Erro ao resetar senha');
    }
  }

  @override
  Future<User?> loginGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // Create a new credential
      final firebaseCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      var userCredential = await _firebaseAuth.signInWithCredential(firebaseCredential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists_with_different-credential') {
        throw AuthException(
            message: 'Login já registrado com outra credencial!');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao realizar o login');
      }
    }
  }

  @override
  Future<void> logout() async{
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
  
  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if(user != null){
      await user.updateDisplayName(name);
    }
  }
}
