import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app_database/database/notes_database.dart';
import 'package:note_app_database/model/note.dart';
import 'package:note_app_database/widget/note_card_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'add_edit_note_screen.dart';
import 'note_detail_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  void refreshNotes() async {
    setState(() {
      isLoading = true;
    });

    notes = await NotesDatabase.instance.readAllNote();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Note App",
          ),
          actions: [searchButton()],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Center(
                      child: Text(
                        "Empty note list!",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      const AddEditNoteScreen()), // add note as parameter
            );

            refreshNotes();
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Are you sure?",
              style: TextStyle(color: Colors.red),
            ),
            content: const Text(
              "Do you went to exit an app",
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: const Text(
                  "Exit",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  Widget? buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 3,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailScreen(noteId: note.id!),
              ));
              refreshNotes();
            },
            child: NoteCardWidget(
              note: note,
              index: index,
            ),
          );
        },
      );

  Widget searchButton() => IconButton(
      onPressed: () {
        if (kDebugMode) {
          print("This feature is not available for now...!");
        }
      },
      icon: const Icon(
        Icons.search,
        size: 32,
      ));
}
