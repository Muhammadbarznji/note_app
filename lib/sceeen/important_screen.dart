import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app_database/database/notes_database.dart';
import 'package:note_app_database/model/note.dart';
import 'package:note_app_database/widget/navigation_drawer.dart';
import 'package:note_app_database/widget/note_card_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'note_detail_screen.dart';

class ImportantScreen extends StatefulWidget {
  const ImportantScreen({Key? key}) : super(key: key);

  @override
  State<ImportantScreen> createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {

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

    notes = await NotesDatabase.instance.readImportantNotes();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
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
            ?  Center(
          child: Text(
            "Empty important list!",
            style: Theme.of(context).textTheme.headline2,
          ),
        )
            : buildNotes(),
      ),
    );
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
