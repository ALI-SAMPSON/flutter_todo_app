import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/services/helpers/api_helpers.dart';

class TodoService {
  static Future<List<Todo>> fetchAllTodos() async {
    List<Todo> todos = [];
    final authResponse = await ApiHelpers.get("/todos");
    for (var todo in authResponse) {
      todos.add(Todo.fromJson(todo));
    }
    debugPrint("Response: ${authResponse.toString()}");
    return todos;
  }

  static Future<Todo> fetchTodo(int id) async {
    final authResponse = await ApiHelpers.get("/todos/$id");
    debugPrint("Response: ${authResponse.toString()}");
    return Todo.fromJson(authResponse);
  }
}
