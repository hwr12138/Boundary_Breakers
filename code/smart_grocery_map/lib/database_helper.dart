import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static String path = "grocery_map_db.db";

  static void _initializeDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)");
    await db.rawInsert('INSERT INTO Test(name, value, num) VALUES(?, ?, ?)', ['name', 123, 12.3]);
    print("initialzed database");
  }

  static void connectToDatabase() async {
    if (_database != null) {
      print("already connected to database");
      return;
    }

    _database = await openDatabase(path, version: 1, onCreate: _initializeDatabase);
    print("connected to database");
  }

  static void disconnectFromDatabase() async {
    if (_database == null) {
      print("not connected to any database");
      return;
    }

    await _database!.close();
    _database = null;
    print("disconnected from database");
  }

  static void getTableItems() async {
    if (_database == null) {
      print("cannot get table items, not connected to a database");
      return;
    }

    List<Map> list = await _database!.rawQuery("SELECT * FROM Test");
    print(list);
  }
}