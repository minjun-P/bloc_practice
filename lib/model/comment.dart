class Comment {
  final String id;
  final String content;

  Comment({required this.id, required this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
    );
  }
}