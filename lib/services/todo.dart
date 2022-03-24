import 'package:hive/hive.dart';
import 'package:todo/model/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('tasks');

    await _tasks.clear();

    await _tasks.add(Task('Kazybek', 'task1', false));
    await _tasks.add(Task('Kazybek', 'task2', true));
    await _tasks.add(Task('Kazybek', 'task3', false));
    await _tasks.add(Task('Meiirbek', 'task1', false));
    await _tasks.add(Task('Meiirbek', 'task2', false));
  }

  Future<List<Task>> getTasks(final String username) async {
    final tasks =
        _tasks.values.where((element) => element.user == username).toList();
    return tasks;
  }

  void addTask(final String task, final String username) {
    _tasks.add(Task(username, task, false));
  }

  Future<void> removeTask(final String task, final String username) async {
    final taskToRemove = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String task, final String username) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    final index = taskToEdit.key as int;
    await _tasks.put(index, Task(username, task, !taskToEdit.complete));
  }
}
