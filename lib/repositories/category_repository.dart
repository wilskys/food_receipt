import '../core/dio_client.dart';
import '../models/category.dart';

class CategoryRepository {
  Future<List<MealCategory>> fetchCategories() async {
    final response = await DioClient.dio.get('/list.php?c=list');

    final List list = response.data['meals'];
    return list.map((e) => MealCategory.fromJson(e)).toList();
  }
}
