import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/models/todo.dart';

class TodoService {
  static Future<List<Todo>> fetchTodos() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
      final List<dynamic> todoJson = json.decode(response.body);

      return todoJson.map((json) => Todo.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load todos: $error');
    }
  }
}
