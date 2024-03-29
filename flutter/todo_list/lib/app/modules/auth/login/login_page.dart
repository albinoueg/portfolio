import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/core/widgets/todo_list_logo.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:todo_list/app/core/widgets/todo_list_text_form_field.dart';
import 'package:todo_list/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      successVoidCallback: (notifier, listener) {},
      everVoidCallback: (notifier, listener) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TodoListTextFormField(
                              labelText: 'E-mail',
                              focusNode: _emailFocusNode,
                              textEditingController:
                                  _emailTextEditingController,
                              formFieldValidator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TodoListTextFormField(
                              labelText: 'Senha',
                              obscureText: true,
                              textEditingController:
                                  _passwordTextEditingController,
                              formFieldValidator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatória'),
                                Validatorless.min(6,
                                    'Senha deve conter ao menos 6 caracteres'),
                              ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (_emailTextEditingController
                                        .text.isNotEmpty) {
                                      context
                                          .read<LoginController>()
                                          .forgotPassword(
                                              _emailTextEditingController.text);
                                    } else {
                                      _emailFocusNode.requestFocus();
                                      Messages.of(context).showWarning(
                                          'Digite um e-mail para recuperar a senha');
                                    }
                                  },
                                  child: const Text('Esqueceu sua senha?'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final formValid =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    if (formValid) {
                                      final email =
                                          _emailTextEditingController.text;
                                      final password =
                                          _passwordTextEditingController.text;
                                      context
                                          .read<LoginController>()
                                          .login(email, password);
                                    }
                                  },
                                  child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Login')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SignInButton(
                              Buttons.Google,
                              text: "Continue com o Google",
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              onPressed: () {
                                context.read<LoginController>().loginGoogle();
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não tem conta?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: const Text('Cadastre-se'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
