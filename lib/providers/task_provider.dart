import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../services/storage_service.dart';

String dateKey(DateTime date) {
  return "${date.year}-${date.month}-${date.day}";
}

final taskProvider =
    StateNotifierProvider<TaskNotifier, Map<String, List<Task>>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<Map<String, List<Task>>> {
  TaskNotifier() : super({}) {
    Future.microtask(() => load());
  }

  Future<void> load() async {
    state = await StorageService.loadTasks();
  }

  void addTask(DateTime date, String title) {
    final key = dateKey(date);
    final tasks = state[key] ?? [];
    final updatedTasks = [...tasks, Task(title: title)];

    state = {...state, key: updatedTasks};

    StorageService.saveTasks(state);
  }

  void toggleTask(DateTime date, int index) {
    final key = dateKey(date);
    final tasks = state[key] ?? [];
    final updatedTasks = [...tasks];

    updatedTasks[index].isDone = !updatedTasks[index].isDone;

    state = {...state, key: updatedTasks};

    StorageService.saveTasks(state);
  }

  void deleteTask(DateTime date, int index) {
    final key = dateKey(date);
    final tasks = state[key] ?? [];
    final updatedTasks = [...tasks];

    updatedTasks.removeAt(index);

    state = {...state, key: updatedTasks};

    StorageService.saveTasks(state);
  }
}
