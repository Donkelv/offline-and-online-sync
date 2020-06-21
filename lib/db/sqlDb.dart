import 'dart:io';

import 'package:Internashala/db/class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class DatabaseSqflite {
  static final _databaseName = "Internashala.db";
  static final _databaseVersion = 1;

  static final table = "intern_data";

  static final columnId = "id";
  static final columnName = "name";
  static final columnPrefe = "hobby";

  DatabaseSqflite._privateConstructor();

  static final DatabaseSqflite instance = DatabaseSqflite._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INT PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnPrefe TEXT NOT NULL
          )
      ''');
  }

  Future<int> saveData(InternSqflite intern) async {
    final Database db = await database;
    var res = await db.insert(
      "$table",
      intern.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(res);
    return res;
  }

  Future<List<InternSqflite>> getUserModelData() async {
    final Database db = await database;
    String sql;
    sql = "SELECT * FROM intern_data";

    var result = await db.rawQuery(sql);
    if (result.length == 0) return null;

    List<InternSqflite> list = result.map((item) {
      return InternSqflite.fromMap(item);
    }).toList();

    print(result);
    return list;
  }
}
