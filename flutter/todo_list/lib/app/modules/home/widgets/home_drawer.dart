import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/todo_list_auth_provider.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final nomeValueNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<TodoListAuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://banner2.cleanpng.com/20181231/fta/kisspng-computer-icons-user-profile-portable-network-graph-circle-svg-png-icon-free-download-5-4714-onli-5c2a3809d6e8e6.1821006915462707298803.jpg';
                  },
                  builder: ((context, value, child) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  }),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<TodoListAuthProvider, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ?? 'Usuário';
                      },
                      builder: ((context, value, child) {
                        return Text(
                          value,
                          style: context.textTheme.headlineSmall,
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Center(
                      child: Text('Alterar Nome'),
                    ),
                    content: TextField(
                      onChanged: (value) => nomeValueNotifier.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (nomeValueNotifier.value.isEmpty) {
                            Messages.of(context).showError('Nome obrigatório');
                          } else {
                            Loader.show(context);
                            await context.read<UserService>().updateDisplayName(nomeValueNotifier.value);
                            Loader.hide();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Alterar'),
                      ),
                    ],
                  );
                },
              );
            },
            title: const Text('Alterar nome'),
          ),
          ListTile(
            onTap: () => context.read<TodoListAuthProvider>().logout(),
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
