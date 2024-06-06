// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/screens/task_list_screen.dart';

void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => TaskProvider()..loadTasks(),
        child: MaterialApp(
          // Удаляем const здесь
          home: TaskListScreen(), // Добавляем const здесь
        ),
      ),
    );

    // Create the Finders.
    final titleFinder = find.text('Todo List');
    // You can add more Finders here if you need to find specific widgets.

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
  });
}
