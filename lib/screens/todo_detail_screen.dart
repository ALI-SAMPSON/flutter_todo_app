import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/services/helpers/api_helpers.dart';
import 'package:flutter_todo_app/services/remote/todo_service.dart';

class TodoDetailScreen extends StatefulWidget {
  final int? id;

  const TodoDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  bool isLoading = false;

  var todo = Todo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodoWithId(widget.id!);
  }

  void fetchTodoWithId(int id) async {
    setState(() => isLoading = true);
    try {
      var response = await TodoService.fetchTodo(id);
      todo = response; // add list to new list of todos
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Todo'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Id: ${todo.id.toString()}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'UserId: ${todo.userId.toString()}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'Title: ${todo.title.toString()}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ));
  }
}
