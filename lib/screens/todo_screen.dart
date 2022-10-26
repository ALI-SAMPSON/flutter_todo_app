import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/screens/todo_detail_screen.dart';
import 'package:flutter_todo_app/services/helpers/api_helpers.dart';
import 'package:flutter_todo_app/services/remote/todo_service.dart';
import 'package:flutter_todo_app/widgets/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool isLoading = false;

  late List<Todo> todos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todos = <Todo>[];
    fetchTodo();
  }

  void fetchTodo() async {
    setState(() => isLoading = true);
    try {
      var response = await TodoService.fetchAllTodos();
      todos = response; // add list to new list of todos
      setState(() => isLoading = false);
    } catch (err) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: todos.length,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TodoDetailScreen(
                            id: todos[index].id,
                          ))),
              child: TodoItem(todo: todos[index]),
            );
          }),
    );
  }
}
