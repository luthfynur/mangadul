class Book {
  final String id;
  final String title;
  final String href;
  final String image;
  final String description;
  final List<dynamic> tags;
  final String contentRating;
  final String status;

  const Book({
    required this.id,
    required this.title,
    required this.href,
    required this.image,
    required this.description,
    required this.tags,
    required this.contentRating,
    required this.status,
  });
}
