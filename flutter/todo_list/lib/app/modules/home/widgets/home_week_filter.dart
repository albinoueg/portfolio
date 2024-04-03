import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text('DIA DA SEMANA', style: context.titleStyle),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 95,
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            onDateChange: (date) {},
          ),
        ),
      ],
    );
  }
}
