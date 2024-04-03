abstract interface class TasksRepository {
  Future<void> save(DateTime date, String description);
}