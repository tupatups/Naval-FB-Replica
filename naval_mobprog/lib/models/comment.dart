class Comment {
  final int id;
  final String body;
  final int postId;
  final String username;
  final String fullName;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.username,
    required this.fullName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      postId: json['postId'] ?? 0,
      username: json['user'] != null
          ? json['user']['username'] ?? ''
          : 'Anonymous',
      fullName: json['user'] != null ? json['user']['fullName'] ?? '' : 'User',
    );
  }
}