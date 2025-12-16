import 'package:sqflite/sqflite.dart';
import '../local_db/favorite_database.dart';
import '../models/favorite_meal.dart';

class FavoriteRepository {
  Future<void> addFavorite(FavoriteMeal meal) async {
    final db = await FavoriteDatabase.database;
    await db.insert(
      'favorite_meals',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String id) async {
    final db = await FavoriteDatabase.database;
    await db.delete('favorite_meals', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FavoriteMeal>> getFavorites() async {
    final db = await FavoriteDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('favorite_meals');

    return maps.map((e) => FavoriteMeal.fromMap(e)).toList();
  }
}
