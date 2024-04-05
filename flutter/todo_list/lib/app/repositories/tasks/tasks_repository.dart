import 'package:todo_list/app/models/task_model.dart';

abstract interface class TasksRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByPeriodo(DateTime start, DateTime end);
  Future<void> checkOrUncheckTask(TaskModel task);
}