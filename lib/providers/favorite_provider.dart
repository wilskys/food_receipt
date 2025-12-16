import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/favorite_meal.dart';
import '../repositories/favorite_repository.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository();
});

final favoriteListProvider =
    StateNotifierProvider<FavoriteNotifier, List<FavoriteMeal>>(
      (ref) => FavoriteNotifier(ref.read(favoriteRepositoryProvider), ref),
    );
final favoriteLoadingProvider = StateProvider<bool>((ref) => true);

class FavoriteNotifier extends StateNotifier<List<FavoriteMeal>> {
  final FavoriteRepository _repo;
  final Ref ref;

  FavoriteNotifier(this._repo, this.ref) : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    ref.read(favoriteLoadingProvider.notifier).state = true;
    state = await _repo.getFavorites();
    ref.read(favoriteLoadingProvider.notifier).state = false;
  }

  Future<void> toggleFavorite(FavoriteMeal meal) async {
    final exists = state.any((e) => e.id == meal.id);

    if (exists) {
      await _repo.removeFavorite(meal.id);
    } else {
      await _repo.addFavorite(meal);
    }

    await loadFavorites();
  }
}
