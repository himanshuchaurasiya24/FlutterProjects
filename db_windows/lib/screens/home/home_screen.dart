import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqfl_windows/models/note.dart';
import 'package:sqfl_windows/repository/notes_repository.dart';
import 'package:sqfl_windows/screens/add_note/add_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Diary',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: NotesRepository.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data found'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AddNoteScreen(
                            note: Note(
                              id: snapshot.data![index].id,
                              title: snapshot.data![index].title,
                              description: snapshot.data![index].description,
                              createdAt: snapshot.data![index].createdAt,
                            ),
                          );
                        },
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      NotesRepository.deleteNote(snapshot.data![index].id!);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: Column(
                            children: [
                              Text(
                                DateFormat(DateFormat.ABBR_MONTH)
                                    .format(snapshot.data![index].createdAt),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                DateFormat(DateFormat.DAY)
                                    .format(snapshot.data![index].createdAt),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19),
                              ),
                              Text(
                                DateFormat('y')
                                    .format(snapshot.data![index].createdAt),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].id.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(
                                    width: 80,
                                  ),
                                  Text(
                                    DateFormat(DateFormat.HOUR_MINUTE).format(
                                        snapshot.data![index].createdAt),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                              Text(
                                snapshot.data![index].description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, height: 1.5),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('Returning from last'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddNoteScreen();
              },
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        label: const Icon(Icons.add),
      ),
    );
  }
}
