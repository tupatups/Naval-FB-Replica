import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/notification.dart' as notif; 

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, String>> notificationData = [
    {
      'name': 'Max Verstappen', 
      'post': 'posted a photo', 
      'desc': 'P1! Simply lovely drive today.', 
    },
    {
      'name': 'Lewis Hamilton', 
      'post': 'commented on your post', 
      'desc': 'Still we rise. Great shot!', 
    },
    {
      'name': 'Lando Norris', 
      'post': 'invited you to a group', 
      'desc': 'Quadrant Streaming & Gaming',
    },
    {
      'name': 'Charles Leclerc', 
      'post': 'shared a memory', 
      'desc': 'Monza 2019 - what a day.', 
    },
    {
      'name': 'Fernando Alonso', 
      'post': 'reacted to your comment', 
      'desc': '😂', 
    },
    {
      'name': 'Carlos Sainz', 
      'post': 'mentioned you', 
      'desc': 'Smooth operator vibes only.', 
    },
    {
      'name': 'George Russell', 
      'post': 'sent you a friend request', 
      'desc': '1 mutual friend (Toto Wolff)', 
    },
    {
      'name': 'Oscar Piastri', 
      'post': 'posted a video', 
      'desc': 'Behind the scenes at McLaren.', 
    },
    {
      'name': 'Daniel Ricciardo', 
      'post': 'liked your photo', 
      'desc': '', 
    },
    {
      'name': 'Sergio Perez', 
      'post': 'tagged you in a post', 
      'desc': 'Ready for the Mexican GP! 🇲🇽', 
    },
    {
      'name': 'Valtteri Bottas', 
      'post': 'updated their status', 
      'desc': 'Cycling through the mountains.', 
    },
    {
      'name': 'Alex Albon', 
      'post': 'shared a link', 
      'desc': 'Williams Racing new livery reveal.', 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      child: ListView.builder(
        itemCount: notificationData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              notif.Notification(
                name: notificationData[index]['name']!,
                post: notificationData[index]['post']!,
                description: notificationData[index]['desc']!,
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}