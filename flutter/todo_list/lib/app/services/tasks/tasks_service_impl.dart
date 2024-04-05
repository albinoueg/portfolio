import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/models/week_task_model.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() async {
    var hoje = DateTime.now();
    return await _tasksRepository.findByPeriodo(hoje, hoje);
  }

  @override
  Future<List<TaskModel>> getTomorrow() async {
    var tomorrowDate = DateTime.now().add(const Duration(days: 1));
    return await _tasksRepository.findByPeriodo(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    var hoje = DateTime.now();
    var startFilter = DateTime(hoje.year, hoje.month, hoje.day, 0, 0, 0);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    endFilter = startFilter.add(const Duration(days: 7));
    final tasks = await _tasksRepository.findByPeriodo(startFilter, endFilter);
    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
    );
  }
  
  @override
  Future<void> checkOrUncheckTask(TaskModel task) => _tasksRepository.checkOrUncheckTask(task);
}
