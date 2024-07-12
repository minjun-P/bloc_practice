import 'dart:convert';

import 'package:bloc_practice/core.dart';
import 'package:bloc_practice/model/todo.dart';
import 'package:bloc_practice/utils/logger.dart';
import 'package:http/http.dart' as http;

class TodoRepository {
  Future<List<Todo>> fetchTodos() async {
    logRepository("todo fetch");
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await http.get(Uri.http(baseUrl, "/todos"));
    final json = jsonDecode(response.body);
    final casted = List<Map<String, dynamic>>.from(json);

    return casted.map((e) => Todo.fromJson(e)).toList();
  }
  
  Future<Todo> addTodo(Todo todo) async {
    logRepository("todo add");
    await Future.delayed(const Duration(milliseconds: 500));
    final res = await http.post(
      Uri.http(baseUrl, '/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return Todo.fromJson(json);
  }

  Future<Todo> updateIsDone(String id, bool isDone) async {
    logRepository("todo update");
    await Future.delayed(const Duration(milliseconds: 500));
    final res = await http.patch(
      Uri.http(baseUrl, '/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isDone': isDone}),
    );
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return Todo.fromJson(json);
  }
}