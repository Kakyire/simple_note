import 'package:simple_note/database/notes_database.dart';
import 'package:simple_note/model/notes.dart';
import 'package:simple_note/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class DBOperations {
  static final _notesDb = NotesDatabase.notesDatabase.database;

  //insert new notes into the database
  static Future<void> insert(Notes notes) async {
    final Database db = await _notesDb;

    await db.insert(Constants.TABLE_NAME, notes.toMap());
    print('Success');
  }

  //retrieve all notes from the database
  static Future<List<Notes>> selectNotes() async {
    final Database db = await _notesDb;

    List<Map<String, dynamic>> map = await db.query(
      Constants.TABLE_NAME,
      orderBy: '${Constants.ID} desc',
    );
    return List.generate(
      map.length,
      (index) => Notes(
        id: map[index][Constants.ID],
        title: map[index][Constants.TITLE],
        note: map[index][Constants.NOTE],
      ),
    );
  }

  //updating the notes
  static void updateNotes(Notes notes) async {
    final Database db = await _notesDb;

    db.update(
      Constants.TABLE_NAME,
      notes.toMap(),
      where: '${Constants.ID} = ?',
      whereArgs: [notes.id],
    );
  }

  //deleting note from the database
  static void deleteNote(int id) async {
    final Database db = await _notesDb;

    db.delete(
      Constants.TABLE_NAME,
      where: '${Constants.ID}=?',
      whereArgs: [id],
    );
  }
}
