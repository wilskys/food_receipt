import '../core/dio_client.dart';
import '../models/meal.dart';

class MealRepository {
  Future<List<Meal>> searchMeals(String query) async {
    if (query.isEmpty) return [];

    final response = await DioClient.dio.get(
      '/search.php',
      queryParameters: {'s': query},
    );

    final list = response.data['meals'];

    if (list == null) return [];

    return (list as List).map((e) => Meal.fromDetailJson(e)).toList();
  }

  Future<Meal> getRandomMeal() async {
    final response = await DioClient.dio.get('/random.php');
    final mealJson = response.data['meals'][0];
    return Meal.fromDetailJson(mealJson);
  }

  Future<List<Meal>> fetchByCategory(String category) async {
    final response = await DioClient.dio.get(
      '/filter.php',
      queryParameters: {'c': category},
    );

    final List list = response.data['meals'];

    return list.map((e) => Meal.fromFilterJson(e)).toList();
  }

  /// DETAIL
  Future<Meal> getMealDetail(String id) async {
    final response = await DioClient.dio.get(
      '/lookup.php',
      queryParameters: {'i': id},
    );

    return Meal.fromDetailJson(response.data['meals'][0]);
  }
}
