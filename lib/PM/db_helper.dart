import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pm_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS PM (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL,
        mobileNo TEXT NOT NULL,
        qualification TEXT NOT NULL,
        post TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertPM(Map<String, dynamic> pmData) async {
    final db = await instance.database;
    return await db.insert('PM', pmData);
  }

  Future<List<Map<String, dynamic>>> getPMs() async {
    final db = await instance.database;
    return await db.query('PM');
  }
  Future<int> deletePM(int id) async {
  final db = await database;
  return await db.delete('PM', where: 'id = ?', whereArgs: [id]);
}

}
