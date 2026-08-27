import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../services/post_service.dart';
import '../models/post.dart';

class NewsfeedScreen extends StatefulWidget {
  const NewsfeedScreen({super.key});

  @override
  State<NewsfeedScreen> createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  final PostService _postService = PostService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _postService.getPosts(); // feth data from dummyjson
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return PostCard(
                postId: post.id,
                userName:
                    'User ${post.userId}', 
                postContent: post.body,
                date: 'Just now',
                numOfLikes: post.likes,
                profileImageUrl:
                    'https://img.icons8.com/?size=100&id=NPW07SMh7Aco&format=png&color=000000',
              );
            },
          );
        },
      ),
    );
  }
}