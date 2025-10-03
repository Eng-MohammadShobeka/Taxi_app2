import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static var instance;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'taxi_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT,
            role TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE rides (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customerId INTEGER,
            driverId INTEGER,
            start TEXT,
            destination TEXT,
            distance REAL,
            price REAL,
            status TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await database;
    return await db.query(table);
  }
}
