import 'package:flutter/material.dart';
import '/database/notes_database.dart';
import '/model/note.dart';
import '/widget/note_form_widget.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  _AddEditNoteScreenState createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool isChangeValue;
  late bool isImportant;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    title = widget.note?.title ?? "";
    description = widget.note?.description ?? "";
    isChangeValue = false;
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: isChangeValue ? _onBackPressed : null,
      child: Scaffold(
        appBar: AppBar(
          actions: [_saveButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            isImportant: isImportant,
            title: title,
            description: description,
            onChangedImportant: (isImportant) => setState(() {
              this.isImportant = isImportant;
              isChangeValue = true;
            }),
            onChangedTitle: (title) => setState(() {
              this.title = title;
              isChangeValue = true;
            }),
            onChangedDescription: (description) => setState(() {
              this.description = description;
              isChangeValue = true;
            }),
          ),
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
              "Discard note",
              style: TextStyle(color: Colors.red),
            ),
            content: const Text(
              "All Changes will be discarded",
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
                  "Discard",
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

  Widget _saveButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.all(7),
      child: TextButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: Colors.pinkAccent,
          onSurface: Colors.black,
        ),
        onPressed: isFormValid ? _addOrUpdateNote : null,
        child: const Text("Save",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      ),
    );
  }

  void _addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await _updateNote();
      } else {
        await _addNote();
      }

      Navigator.of(context).pop();
    }
  }

  _updateNote() async {
    final note = widget.note!.copy(
        isImportant: isImportant,
        title: title,
        description: description,
        lastEditTime: DateTime.now());

    await NotesDatabase.instance.update(note);
  }

  _addNote() async {
    final note = Note(
      isImportant: isImportant,
      title: title,
      description: description,
      lastEditTime: DateTime.now(),
      createTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
