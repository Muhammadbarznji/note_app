import 'package:flutter/material.dart';
import '/database/notes_database.dart';
import '/model/note.dart';
import '/widget/navigation_drawer.dart';
import '/widget/note_card_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'note_detail_screen.dart';

class ImportantScreen extends StatefulWidget {
  const ImportantScreen({Key? key}) : super(key: key);

  @override
  State<ImportantScreen> createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {
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

    _notes = await NotesDatabase.instance.readImportantNotes();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Import notes",
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
    );
  }

  Widget? buildNotes() => StaggeredGridView.countBuilder(
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
