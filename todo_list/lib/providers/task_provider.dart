import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await DatabaseHelper().getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DatabaseHelper().insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper().updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await DatabaseHelper().deleteTask(id);
    await loadTasks();
  }

  void sortTasksByPriority() {
    _tasks.sort((a, b) => a.priority.compareTo(b.priority));
    notifyListeners();
  }

  void sortTasksByDeadline() {
    _tasks.sort(
        (a, b) => a.deadline?.compareTo(b.deadline ?? DateTime.now()) ?? 0);
    notifyListeners();
  }

  void sortTasksByTitle() {
    _tasks.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }
}
