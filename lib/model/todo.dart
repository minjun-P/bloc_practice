import 'package:bloc_practice/utils/uuid.dart';

class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.isDone,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  factory Todo.newOne(String title) {
    return Todo(
      id: generateUUID(),
      title: title,
      isDone: false,
    );
  }
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
    );
  }
}
