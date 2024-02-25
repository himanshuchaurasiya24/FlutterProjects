import 'package:flutter/material.dart';
import 'package:sqfl_windows/models/note.dart';
import 'package:sqfl_windows/repository/notes_repository.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
    this.note,
  });
  final Note? note;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  bool isUpdate = false;
  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
    if (widget.note != null) {
      isUpdate = true;
    }
    super.initState();
  }

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? 'Update Note' : 'Add Note',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              isUpdate ? _updateNote() : _insertNote();
              Navigator.pop(context, true);
            },
            icon: isUpdate ? const Icon(Icons.update) : const Icon(Icons.done),
          ),
          if (isUpdate)
            IconButton(
              onPressed: () {
                NotesRepository.deleteNote(widget.note!.id!).then(
                  (value) => Navigator.pop(context, true),
                );
              },
              icon: const Icon(Icons.delete),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(isUpdate ? widget.note!.id.toString() : ''),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _insertNote() async {
    final note = Note(
      title: _titleController.text,
      description: _descriptionController.text,
      createdAt: DateTime.now(),
    );
    await NotesRepository.insert(note: note);
  }

  _updateNote() async {
    final note = Note(
      id: widget.note!.id,
      title: _titleController.text,
      description: _descriptionController.text,
      createdAt: widget.note!.createdAt,
    );
    await NotesRepository.updateNotes(note: note);
  }
}
