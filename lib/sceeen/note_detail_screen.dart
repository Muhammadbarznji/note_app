import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app_database/database/notes_database.dart';
import 'package:note_app_database/model/note.dart';

import 'add_edit_note_screen.dart';

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({Key? key, required this.noteId}) : super(key: key);

  final int noteId;

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late Note? note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });

    note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(5),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  Text(
                    note!.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    DateFormat.yMMMd().format(note!.createdTime),
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    note!.description,
                    style: const TextStyle(color: Colors.purpleAccent, fontSize: 10),
                  )
                ],
              ),
            ),
    );
  }

  Widget editButton() => IconButton(
        icon: const Icon(Icons.edit_outlined),
        onPressed: () async {
          if (isLoading) {
            return;
          }
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddEditNoteScreen(note: note)));
          refreshNote();
        },
      );

  Widget deleteButton() => IconButton(
      onPressed: () async {
        if (isLoading) {
          return;
        }
        await NotesDatabase.instance.delete(widget.noteId);
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ));
}
