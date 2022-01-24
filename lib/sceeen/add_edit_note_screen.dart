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
  bool isChangeValue = false;
  late bool isImportant;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
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
    );
  }


  Widget saveButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.all(7),
      child: TextButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: Colors.pinkAccent,
          onSurface: Colors.black,
        ),
        onPressed: isFormValid ? addOrUpdateNote : null,
        child: const Text("Save",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        if(isChangeValue){
          print("dialog box");
        }else{
          print("update");
        }
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  updateNote() async {
    final note = widget.note!
        .copy(isImportant: isImportant, title: title, description: description);

    await NotesDatabase.instance.update(note);
  }

  addNote() async {
    final note = Note(
        isImportant: isImportant,
        title: title,
        description: description,
        createdTime: DateTime.now());

    await NotesDatabase.instance.create(note);
  }
}
