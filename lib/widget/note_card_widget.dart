import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app_database/model/note.dart';

final _lightColors = [
  const Color(0xFFFFFFFF),
  const Color(0xffF28B83),
  //Color(0xFFFCBC05),
  const Color(0xFFFFF476),
  const Color(0xFFCBFF90),
  const Color(0xFFA7FEEA),
  const Color(0xFFE6C9A9),
  const Color(0xFFE8EAEE),
  const Color(0xFFA7FEEA),
  const Color(0xFFCAF0F8)
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({Key? key, required this.note, required this.index})
      : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    final getMinHeight = getNoteBoxHeight(index);
    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: getMinHeight),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Icon(
                    note.isImportant ? Icons.star_outlined : null,
                    color: Colors.amber,
                    size: 28,
                  )
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                note.title,
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getNoteBoxHeight(int index) {
    switch (index) {
      case 0:
      case 3:
        return 100;
      case 1:
      case 2:
        return 150;
      default:
        return 120;
    }
  }
}
