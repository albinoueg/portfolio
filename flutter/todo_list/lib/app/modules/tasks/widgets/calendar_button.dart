import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/modules/tasks/tasks_create_controller.dart';

class CalendarButton extends StatelessWidget {
  CalendarButton({super.key});

  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var duration = const Duration(days: 365);
        var initialDate = DateTime.now();
        var firstDate = initialDate.subtract(duration);
        var lastDate = initialDate.add(duration);
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );

        context.read<TasksCreateController>().selectedDate = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Selector<TasksCreateController, DateTime?>(
              builder: (context, selectedDate, child) {
                if (selectedDate != null) {
                  return Text(
                    dateFormat.format(selectedDate),
                    style: context.titleStyle,
                  );
                } else {
                  return Text(
                    'Selecione uma data',
                    style: context.titleStyle,
                  );
                }
              },
              selector: (context, controller) => controller.selectedDate,
            ),
          ],
        ),
      ),
    );
  }
}
