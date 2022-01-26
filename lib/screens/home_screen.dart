import 'package:flutter/material.dart';
import '/database/notes_database.dart';
import '/model/note.dart';
import '/widget/navigation_drawer.dart';
import '/widget/note_card_widget.dart';
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
  final GlobalKey _key = GlobalKey();
  late List<Note> _notes;
  bool _isLoading = false;

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
      _isLoading = true;
    });

    _notes = await NotesDatabase.instance.readAllNote();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Note App",
          ),
          actions: [searchButton()],
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : _notes.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/empty_box.png",
                        ),
                        Text(
                          "Empty list!",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
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
        key: _key,
        padding: const EdgeInsets.all(8),
        itemCount: _notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 3,
        itemBuilder: (context, index) {
          final note = _notes[index];
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
      },
      icon: const Icon(
        Icons.search,
        size: 32,
      ));
}
