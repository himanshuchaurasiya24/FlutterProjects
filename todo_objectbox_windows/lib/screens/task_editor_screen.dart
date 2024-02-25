import 'package:flutter/material.dart';
import 'package:todo_objectbox_windows/main.dart';
import 'package:todo_objectbox_windows/models/todo_entity.dart';
import 'package:todo_objectbox_windows/objectbox.g.dart';

class TaskEditorScreen extends StatefulWidget {
  const TaskEditorScreen({super.key});

  @override
  State<TaskEditorScreen> createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  Box<TodoEntity> todoBox = objectBox.store.box<TodoEntity>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text(
          'Create a new task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade900,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  hintText: 'Type your task Task title eg: Buy some milk..',
                  hintStyle: const TextStyle(color: Colors.white60),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  hintText: 'Type your task description',
                  hintStyle: const TextStyle(color: Colors.white60),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      String todoTitle = _titleController.text;
                      String tododescription = _descriptionController.text;
                      TodoEntity entity = TodoEntity(
                          task_title: todoTitle,
                          task_description: tododescription,
                          creation_date: DateTime.now(),
                          task_done: false);
                      todoBox.put(entity);
                      Navigator.pop(context);
                    },
                    color: Colors.blueAccent,
                    elevation: 0.0,
                    child: const Text('Save'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
