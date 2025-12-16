class BlogPost {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String category;
  final DateTime date;
  final String image; // 👈 ADD

  BlogPost({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    required this.date,
    required this.image,
  });
}
