import 'package:flutter/material.dart';
import 'package:note_app_database/database/notes_database.dart';
import 'package:note_app_database/model/note.dart';
import 'package:note_app_database/widget/note_form_widget.dart';

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
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? "";
    description = widget.note?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [saveButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            onChangedImportant: (isImportant) => setState(() {
              this.isImportant = isImportant;
            }),
            onChangedNumber: (number) => setState(() {
              this.number = number;
            }),
            onChangedTitle: (title) => setState(() {
              this.title = title;
            }),
            onChangedDescription: (description) => setState(() {
              this.description = description;
            }),
          ),
        ));
  }



  Widget saveButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.lightGreenAccent,
          primary: isFormValid ? null : Colors.purple,
        ),
        onPressed: addOrUpdateNote,
        child: const Text("Save"),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  updateNote() async {
    final note = widget.note!.copy(
        isImportant: isImportant,
        number: number,
        title: title,
        description: description);

    await NotesDatabase.instance.update(note);
  }

  addNote() async {
    final note = Note(
        isImportant: isImportant,
        title: title,
        number: number,
        description: description,
        createdTime: DateTime.now());

    await NotesDatabase.instance.create(note);
  }
}
