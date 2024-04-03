import 'package:todo_list/app/core/notifier/default_chage_notifier.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';

class TasksCreateController extends DefaultChageNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TasksCreateController({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  void save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    } catch (e) {
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
