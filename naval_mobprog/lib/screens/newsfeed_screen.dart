import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});
  
  final List<Map<String, dynamic>> _posts = const [
    {
      'userName': 'Christopher Naval',
      'postContent': 'Bossing! may gising pa ba?',
      'numOfLikes': 150,
      'date': 'Just now',
      'hasImage': false,
    },
    {
      'userName': 'Christopher Naval',
      'postContent': 'Bili siya sa canteen.',
      'numOfLikes': 42,
      'date': '15 mins ago',
      'hasImage': true,
    },
    {
      'userName': 'Christopher Naval',
      'postContent': 'Bakal ako.',
      'numOfLikes': 89,
      'date': '1 hr ago',
      'hasImage': true,
    },
    {
      'userName': 'Christopher Naval',
      'postContent': 'Dito ako Sampaloc, Manila. 500 cash sa makakakita sakin!!',
      'numOfLikes': 200,
      'date': '3 hrs ago',
      'hasImage': false,
    },
    {
      'userName': 'Christopher Naval',
      'postContent': 'Looking right because you left me.',
      'numOfLikes': 75,
      'date': 'Yesterday',
      'hasImage': true,
    },
    {
      'userName': 'Christopher Naval',
      'postContent': 'Lodi ko yan',
      'numOfLikes': 120,
      'date': '2 days ago',
      'hasImage': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], 
      child: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          
          return Column(
            children: [
              NewsFeedCard(
                userName: post['userName'],
                postContent: post['postContent'],
                numOfLikes: post['numOfLikes'],
                date: post['date'],
                hasImage: post['hasImage'] ?? false, 
              ),
              const SizedBox(height: 10), 
            ],
          );
        },
      ),
    );
  }
}