import 'package:flutter/material.dart';
import 'package:food_receipt/features/home/widgets/filtered_recipe_list.dart';
import 'widgets/search_bar.dart';
import 'widgets/hero_banner.dart';
import 'widgets/category_section.dart';
import 'widgets/section_header.dart';
import 'widgets/recipe_card_grid.dart';
import 'widgets/recipe_card_grid.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/search_provider.dart';
import 'widgets/search_result_grid.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
              ),
              const Text(
                "Let's Cook Something Special Today 🔥",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const HomeSearchBar(),
              const SizedBox(height: 16),

              /// 🔥 JIKA SEARCH AKTIF
              if (query.isNotEmpty) ...[
                const SearchResultGrid(),
              ] else ...[
                const SectionHeader(title: 'Recipe of the day'),
                const SizedBox(height: 12),
                const HeroBanner(),
                const SizedBox(height: 24),
                const CategorySection(),
                const SizedBox(height: 16),
                const FilteredRecipeList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
