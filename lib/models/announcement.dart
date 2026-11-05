class Announcement {
  final String id;
  final String title;
  final String body;
  final String category;
  final String author;
  final DateTime createdAt;
  final bool isDemo;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.author,
    required this.createdAt,
    this.isDemo = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'body': body, 'category': category,
    'author': author, 'createdAt': createdAt.toIso8601String(), 'isDemo': isDemo,
  };

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    id: json['id'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    category: json['category'] as String,
    author: json['author'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    isDemo: json['isDemo'] as bool? ?? false,
  );
}
