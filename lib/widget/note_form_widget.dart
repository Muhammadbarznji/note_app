import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget(
      {Key? key,
      this.isImportant = false,
      this.number = 0,
      this.title = '',
      this.description = '',
      required this.onChangedImportant,
      required this.onChangedNumber,
      required this.onChangedTitle,
      required this.onChangedDescription})
      : super(key: key);

  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Switch(value: isImportant, onChanged: onChangedImportant),
/*                  Expanded(
                      child: Slider(
                          value: (number).toDouble(),
                          min: 0,
                          max: 5,
                          divisions: 5,
                          onChanged: (number) =>
                              onChangedNumber(number.toInt())))*/
                ],
              ),
              buildTitle(),
              const SizedBox(
                height: 8.0,
              ),
              buildDescription(),
              const SizedBox(
                height: 16,
              ),
            ],
          )),
    );
  }


  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.deepOrange),
        ),
        validator: (title) => title != null && title.isEmpty
            ? "The title cannot be empty!"
            : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
    maxLines: 24,
        initialValue: description,
        style: const TextStyle(color: Colors.pinkAccent, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Type something...",
          hintStyle: TextStyle(color: Colors.blueGrey),
        ),
        validator: (title) => title != null && title.isEmpty
            ? "The description cannot empty"
            : null,
        onChanged: onChangedDescription,
      );
}
