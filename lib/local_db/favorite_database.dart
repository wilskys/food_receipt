import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), 'favorite.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorite_meals (
            id TEXT PRIMARY KEY,
            name TEXT,
            thumbnail TEXT
          )
        ''');
      },
    );

    return _db!;
  }
}
