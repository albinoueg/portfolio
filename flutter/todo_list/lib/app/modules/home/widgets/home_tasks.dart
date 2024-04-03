import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
          height: 20,
        ),
        Text(
          'TASKS\'S DE HOJE',
          style: context.titleStyle,
        ),
        Column(
          children: [
            Task(),
            Task(),
            Task(),
          ],
        ),
        ],
      ),
    );
  }
}
