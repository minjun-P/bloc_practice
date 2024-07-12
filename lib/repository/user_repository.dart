import 'dart:convert';

import 'package:bloc_practice/core.dart';
import 'package:bloc_practice/model/user.dart';
import 'package:bloc_practice/utils/logger.dart';
import 'package:http/http.dart' as http;


class UserRepository {
  Future<User> getUser() async {
    logRepository("get User");
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate a network request
    final response = await http.get(Uri.http(baseUrl, "/user"));
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return User.fromJson(json);
  }
}