import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../models/comment.dart';

class PostService {
  static const String host = 'https://dummyjson.com';

  Future<List<Post>> getPosts({int limit = 30, int skip = 0}) async {
    final uri = Uri.parse('$host/posts?limit=$limit&skip=$skip');
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List postsJson = data['posts'] ?? [];
      return postsJson.map((p) => Post.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }

  Future<List<Post>> getUserPosts(int userId) async {
    final uri = Uri.parse('$host/posts/user/$userId');
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List postsJson = data['posts'] ?? [];
      return postsJson.map((p) => Post.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load user posts: ${response.statusCode}');
    }
  }

  // NEW: Fetch comments for a specific post
  Future<List<Comment>> getPostComments(int postId) async {
    final uri = Uri.parse('$host/posts/$postId/comments');
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List commentsJson = data['comments'] ?? [];
      return commentsJson.map((c) => Comment.fromJson(c)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // NEW: Add a comment (Mock request to DummyJSON)
  Future<Comment> addComment(int postId, int userId, String body) async {
    final uri = Uri.parse('$host/comments/add');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'body': body, 'postId': postId, 'userId': userId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add comment');
    }
  }
}