import 'dart:convert';

import 'package:bloc_practice/core.dart';
import 'package:bloc_practice/model/comment.dart';
import 'package:bloc_practice/utils/logger.dart';
import 'package:http/http.dart' as http;


class CommentRepository {
  Future<List<Comment>> fetchCommentsByTodoId(String todoId) async {
    logRepository("fetch comments by todoId $todoId");
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await http.get(Uri.http(baseUrl, "/todos/$todoId/comments"));
    final json = jsonDecode(response.body);
    final casted = List<Map<String, dynamic>>.from(json);

    return casted.map((e) => Comment.fromJson(e)).toList();
  }
}