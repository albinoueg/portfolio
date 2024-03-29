import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/todo_list_auth_provider.dart';
import 'package:todo_list/app/modules/home/widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HOME'),
        ),
        drawer: HomeDrawer(),
        body: Center(
          child: TextButton(
            onPressed: () {
              context.read<TudoListAuthProvider>().logout();
            },
            child: const Text('logout'),
          ),
        ));
  }
}
