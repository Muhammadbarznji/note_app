import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget(
      {Key? key,
      this.isImportant = false,
      this.title = '',
      this.description = '',
      required this.onChangedImportant,
      required this.onChangedTitle,
      required this.onChangedDescription})
      : super(key: key);

  final bool isImportant;
  final String title;
  final String description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SwitchListTile(
                value: isImportant,
                onChanged: onChangedImportant,
                activeColor: Colors.amber,
                title: Text(
                  "Is important",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              buildTitle(context),
              const SizedBox(
                height: 8.0,
              ),
              buildDescription(context),
              const SizedBox(
                height: 16,
              ),
            ],
          )),
    );
  }

  Widget buildTitle(BuildContext context) => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: Theme.of(context).textTheme.headline2,
        decoration: const InputDecoration(
          hintText: "Title",
        ),
        validator: (title) => title != null && title.isEmpty
            ? "The title cannot be empty!"
            : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription(BuildContext context) => TextFormField(
        maxLines: 15,
        initialValue: description,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
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
