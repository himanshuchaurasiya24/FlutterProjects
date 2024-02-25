import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:todo_objectbox_windows/main.dart';
import 'package:todo_objectbox_windows/models/todo_entity.dart';
import 'package:todo_objectbox_windows/screens/task_editor_screen.dart';
import 'package:todo_objectbox_windows/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<TodoEntity>? todoBox;
  Stream<List<TodoEntity>>? fetchAllTask;
  @override
  void initState() {
    super.initState();
    todoBox = objectBox.store.box<TodoEntity>();
    print(todoBox!.count());
    setState(() {
      fetchAllTask = todoBox!
          .query()
          .watch(triggerImmediately: true)
          .map((event) => event.find());
    });
  }

  @override
  void dispose() {
    super.dispose();
    objectBox.store.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "👋 Welcome sir",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Today\'s tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const TaskEditorScreen();
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                    label: const Text(
                      'Add a new task',
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.white,
              ),
              StreamBuilder(
                stream: fetchAllTask,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'No data found',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!
                              .map(
                                (e) => TaskWidget(
                                  task: e,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }
                  }
                  return const Center(
                    child: Text(
                      'returning from the last',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
