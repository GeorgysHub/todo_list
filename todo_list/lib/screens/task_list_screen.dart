// lib/screens/task_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart'; // Импортируем экран добавления задачи
import 'edit_task_screen.dart'; // Импортируем экран редактирования задачи

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _sortCriterion = 'Priority';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _sortCriterion = value;
                _sortTasks(context);
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Priority',
                child: Text('Sort by Priority'),
              ),
              const PopupMenuItem(
                value: 'Deadline',
                child: Text('Sort by Deadline'),
              ),
              const PopupMenuItem(
                value: 'Title',
                child: Text('Sort by Title'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Навигация на экран добавления новой задачи
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.tasks.isEmpty) {
            return const Center(child: Text('No tasks available'));
          }
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text('Priority: ${task.priority}'),
                onTap: () {
                  // Навигация на экран редактирования задачи
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(task: task),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // Подтверждение удаления
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text(
                            'Are you sure you want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (confirm) {
                      taskProvider.deleteTask(task.id!);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _sortTasks(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    switch (_sortCriterion) {
      case 'Priority':
        taskProvider.sortTasksByPriority();
        break;
      case 'Deadline':
        taskProvider.sortTasksByDeadline();
        break;
      case 'Title':
        taskProvider.sortTasksByTitle();
        break;
    }
  }
}
