import 'package:flutter/material.dart';
import 'package:food_receipt/data/blog_dummy_data.dart';
import 'package:go_router/go_router.dart';
import '../../models/blog_post.dart';
import 'widgets/blog_card.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(title: const Text('Cooking Blog'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// FEATURED
          Text(
            'Featured Tip',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          BlogCard(
            post: dummyBlogs.first,
            onTap: () {
              context.push('/blog/${dummyBlogs.first.id}');
            },
          ),

          const SizedBox(height: 24),

          /// ALL POSTS
          Text(
            'Latest Articles',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ...dummyBlogs
              .skip(1)
              .map(
                (post) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: BlogCard(
                    post: post,
                    onTap: () {
                      context.push('/blog/${post.id}');
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
