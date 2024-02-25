import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:todo_objectbox_windows/main.dart';
import 'package:todo_objectbox_windows/models/todo_entity.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({required this.task, super.key});
  final TodoEntity task;
  @override
  State<TaskWidget> createState() => TaskWidgetState();
}

class TaskWidgetState extends State<TaskWidget> {
  Box<TodoEntity> taskBox = objectBox.store.box<TodoEntity>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(6.0),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              side: const BorderSide(
                color: Colors.white,
              ),
              hoverColor: Colors.white,
              value: widget.task.task_done,
              onChanged: (value) {
                widget.task.task_done = value;
                taskBox.put(widget.task);
              }),
          Expanded(
            child: ListTile(
              title: Text(
                widget.task.task_title!,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.task.task_description!,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              taskBox.remove(widget.task.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
