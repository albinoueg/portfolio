import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/todo_list_auth_provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<TodoListAuthProvider, String>(
        builder: (context, value, child) {
          return Text(
            'Olá, $value!',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );
        },
        selector: (context, authProvider) =>
            authProvider.user?.displayName ?? 'Usuário',
      ),
    );
  }
}
