import 'package:flutter/material.dart';
import 'package:food_receipt/data/blog_dummy_data.dart';
import 'package:food_receipt/features/blog/blog_detail_page.dart';
import 'package:food_receipt/features/detail/meal_detail_page.dart';
import 'package:food_receipt/features/main/main_page.dart';
import 'package:food_receipt/features/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../features/home/home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashPage()),
    GoRoute(path: '/home', builder: (_, __) => const HomePage()),
    GoRoute(path: '/main', builder: (_, __) => const MainPage()),
    GoRoute(
      path: '/meal/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MealDetailPage(mealId: id);
      },
    ),

    /// BLOG DETAIL
    GoRoute(
      path: '/blog/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        final post = dummyBlogs.firstWhere((e) => e.id == id);

        return BlogDetailPage(post: post);
      },
    ),
  ],
);
