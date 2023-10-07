class BookTag {
  final String id;
  final String name;
  final String group;

  const BookTag({required this.id, required this.name, required this.group});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'group': group,
    };
  }
}
