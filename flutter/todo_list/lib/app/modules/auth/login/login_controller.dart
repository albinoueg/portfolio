import 'package:todo_list/app/core/notifier/default_chage_notifier.dart';
import 'package:todo_list/app/exception/auth_exception.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class LoginController extends DefaultChageNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);
      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha inválidos');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassord(email);
      infoMessage = 'Reset de senha enviado para o seu e-mail';
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> loginGoogle() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.loginGoogle();
      if (user != null) {
        success();
      } else{
        setError('Erro ao efetuar o login');
        _userService.logout();
      }
    } on AuthException catch (e) {
      _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
