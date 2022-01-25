const String tableNotes = "notes";

class NoteFields {
  static const List<String> values = [
    id,
    isImportant,
    title,
    description,
    lastEditTime,
    createTime
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String title = 'title';
  static const String description = 'description';
  static const String lastEditTime = 'lastEditTime';
  static const String createTime = 'createdTime';
}

class Note {
  final int? id;
  final bool isImportant;
  final String title;
  final String description;
  final DateTime lastEditTime;
  final DateTime createTime;

  const Note(
      {this.id,
      required this.isImportant,
      required this.title,
      required this.description,
      required this.lastEditTime,
      required this.createTime});

  Note copy(
          {int? id,
          bool? isImportant,
          String? title,
          String? description,
          DateTime? lastEditTime,
          DateTime? createTime}) =>
      Note(
          id: id ?? this.id,
          isImportant: isImportant ?? this.isImportant,
          title: title ?? this.title,
          description: description ?? this.description,
          lastEditTime: lastEditTime ?? this.lastEditTime,
          createTime: createTime ?? this.createTime);

  static Note fromJson(Map<String, dynamic> json) => Note(
      id: json[NoteFields.id] as int?,
      isImportant: json[NoteFields.isImportant] == 1,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      lastEditTime: DateTime.parse(json[NoteFields.lastEditTime] as String),
      createTime: DateTime.parse(json[NoteFields.createTime] as String));

  Map<String, dynamic> toJson() => {
        NoteFields.id: id,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.lastEditTime: lastEditTime.toIso8601String(),
        NoteFields.createTime: createTime.toIso8601String()
      };
}
