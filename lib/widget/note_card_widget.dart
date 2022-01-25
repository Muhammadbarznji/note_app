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
    final createTime = DateFormat('dd/MMM/yyy hh:mm').format(note.createTime);
    final lastEditTime = DateFormat('dd/MMM/yyy hh:mm').format(note.lastEditTime);
    bool isUpdate = (note.lastEditTime.subtract(const Duration(seconds: 45)).isAfter(note.createTime));
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    createTime,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Icon(
                    note.isImportant ? Icons.star_outlined : null,
                    color: Colors.amber,
                    size: 28,
                  )
                ],
              ),
              Text(isUpdate ? lastEditTime: "", style: const TextStyle(color: Colors.black)),
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
        return 130;
      case 1:
      case 2:
        return 160;
      default:
        return 120;
    }
  }
}
