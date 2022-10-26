import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo? todo;

  const TodoItem({Key? key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.green.withOpacity(0.3),
            radius: 16.0,
            child: const Icon(
              Icons.book, size: 20,
              color: Colors.green,
            )),
        title: Text(todo!.id.toString()),
        subtitle: Text(todo!.title!),
      ),
    );
  }
}
