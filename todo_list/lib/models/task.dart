class Task {
  final int? id;
  final String title;
  final int priority;
  final DateTime? deadline;

  Task({this.id, required this.title, required this.priority, this.deadline});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'priority': priority,
      'deadline': deadline?.toIso8601String(),
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      priority: map['priority'],
      deadline:
          map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
    );
  }
}
