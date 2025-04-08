import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('leaderboard.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE leaderboard (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        playerName TEXT NOT NULL,
        score INTEGER NOT NULL,
        difficulty TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertScore(String name, int score, String difficulty) async {
    final db = await instance.database;
    await db.insert(
      'leaderboard',
      {
        'playerName': name,
        'score': score,
        'difficulty': difficulty,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getTopScores({String? difficulty}) async {
    final db = await instance.database;

    return await db.query(
      'leaderboard',
      where: difficulty != null ? 'difficulty = ?' : null,
      whereArgs: difficulty != null ? [difficulty] : null,
      orderBy: 'score DESC',
      limit: 10,
    );
  }
}
