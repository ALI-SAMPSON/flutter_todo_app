import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/screens/todo_detail_screen.dart';
import 'package:flutter_todo_app/services/helpers/api_helpers.dart';
import 'package:flutter_todo_app/services/remote/todo_service.dart';

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
              child: Container(
                //height: 200,
                padding: EdgeInsets.all(4.0),
                margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.green.withOpacity(0.2),
                      radius: 16.0,
                      child: Icon(
                        Icons.book,
                        color: Colors.green,
                      )),
                  title: Text(todos[index].id.toString()),
                  subtitle: Text(todos[index].title!),
                ),
              ),
            );
          }),
    );
  }
}
