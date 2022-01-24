import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app_database/database/notes_database.dart';
import 'package:note_app_database/model/note.dart';

import 'add_edit_note_screen.dart';
import 'home_screen.dart';

class NoteDetailScreen extends StatefulWidget {
  static const String id = "/noteDetailScreen";

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
              padding: const EdgeInsets.all(10),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  Text(note!.title,
                      style: Theme.of(context).textTheme.headline1),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    DateFormat.yMMMd().format(note!.createdTime),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    color: Colors.black54,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.7,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      //note!.description,
                      "Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more. Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more. Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more. Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more. Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more. Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more.Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more. Adapting an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more.",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget editButton() => IconButton(
        icon: const Icon(
          Icons.edit_outlined,
        ),
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
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Delete note'),
            content: const Text('Do you went delete this note?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (isLoading) {
                    return;
                  }
                  await NotesDatabase.instance.delete(widget.noteId);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()));
                  //Navigator.of(context).pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ));
}
