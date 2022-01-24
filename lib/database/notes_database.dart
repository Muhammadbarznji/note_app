import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/note.dart';
import 'package:path_provider/path_provider.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase("note.db");
    return _database!;
  }

  Future<Database> _initDatabase(String nameDatabase) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final path = join(appDocDir.toString(), nameDatabase);
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    try {
      await db.execute('''
                CREATE TABLE $tableNotes ( 
                  ${NoteFields.id} $idType, 
                  ${NoteFields.isImportant} $boolType,
                  ${NoteFields.title} $textType,
                  ${NoteFields.description} $textType,
                  ${NoteFields.time} $textType
                  )
      ''');
    } catch (e) {
      throw Exception(["Create table Exception $e"]);
    }
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    try {
      final id = await db.insert(tableNotes, note.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return note.copy(id: id);
    } catch (e) {
      throw Exception(["Create new note Exception $e"]);
    }
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    List<Map<String, dynamic>> result = await db.query(tableNotes,
        columns: NoteFields.values,
        where: '${NoteFields.id} =?',
        whereArgs: [id]);

    if (result.isNotEmpty) {
      return Note.fromJson(result.first);
    } else {
      throw Exception(["Can't find this $id id"]);
    }
  }

  Future<List<Note>> readAllNote() async {
    final db = await instance.database;
    const orderSchema = "${NoteFields.time} ASC";
    List<Map<String, dynamic>> result =
        await db.query(tableNotes, orderBy: orderSchema);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;
    int result;
    try {
      result = await db.update(tableNotes, note.toJson(),
          where: '${NoteFields.id} = ?', whereArgs: [note.id]);
      return result;
    } catch (e) {
      throw Exception(["Update Exception $e"]);
    }
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    int result;
    try {
      result = await db
          .delete(tableNotes, where: '${NoteFields.id} = ?', whereArgs: [id]);
      return result;
    } catch (e) {
      throw Exception(["Delete Exception $e"]);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
