import 'package:path/path.dart';
import 'package:simple_note/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  final String _dbName = 'simple_notes.db';

  //private construct to allow singleton pattern
  NotesDatabase._();

  //instance of the class to be call outside the class
  static final NotesDatabase notesDatabase = NotesDatabase._();

  Database _database;

  //only have single reference to this at a time
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: _createDatabase, version: 1);

    return _database;
  }

  //create table if it is not already existed
  Future _createDatabase(Database db, int version) async {
    await db.execute(
      // 'CREATE TABLE  notes(id INTEGER PRIMARY KEY,title TEXT, note TEXT)',
      'CREATE TABLE  ${Constants.TABLE_NAME}'
      '(${Constants.ID} INTEGER PRIMARY KEY,${Constants.TITLE} TEXT, ${Constants.NOTE} TEXT)',
    );
  }
}
