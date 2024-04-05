import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list/app/core/widgets/todo_list_text_form_field.dart';
import 'package:todo_list/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
      context: context,
      successVoidCallback: (notifier, listener) {
        listener.dispose();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(
                  fontSize: 10,
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Cadastro',
              style: TextStyle(
                  fontSize: 15,
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: context.primaryColor.withAlpha(20),
              child: const Icon(Icons.arrow_back_ios_outlined),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListTextFormField(
                    labelText: 'E-mail',
                    textEditingController: _emailController,
                    formFieldValidator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail inválido')
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListTextFormField(
                    labelText: 'Senha',
                    obscureText: true,
                    textEditingController: _passwordController,
                    formFieldValidator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                          6, 'Senha deve ter pelo menos 6 caracteres')
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListTextFormField(
                    labelText: 'Confirmar Senha',
                    obscureText: true,
                    textEditingController: _confirmPasswordController,
                    formFieldValidator: Validatorless.multiple([
                      Validatorless.required('Confirmar Senha obrigatória'),
                      Validatorless.compare(
                          _passwordController, 'Senha não confere')
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;

                        if (formValid) {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      child: const Padding(
                          padding: EdgeInsets.all(10), child: Text('Salvar')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
