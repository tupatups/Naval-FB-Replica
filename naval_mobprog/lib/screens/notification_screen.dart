import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naval_mobprog/widgets/notification.dart' as notif;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<String> profileImages = [
    'https://img.icons8.com/?size=100&id=iuxCgY2psikE&format=png&color=000000',
    'https://img.icons8.com/?size=100&id=enhXU0wuHL8s&format=png&color=000000',
    'https://img.icons8.com/?size=100&id=M9iaNrWtUROf&format=png&color=000000',
    'https://img.icons8.com/?size=100&id=KxtY3rktVoKg&format=png&color=000000',
    'https://img.icons8.com/?size=100&id=9XcGFWDvUMi7&format=png&color=000000',
    'https://img.icons8.com/?size=100&id=NDixIIZr9Mpc&format=png&color=000000',
  ];

  String getRandomProfileImage(int index) {
    return profileImages[index % profileImages.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            notif.Notification(
              postId: 1,
              name: 'Steve Jobs',
              post: 'Innovation Through Design',
              description: 'The intersection of technology and humanity creates extraordinary products. Stay hungry, stay foolish, and never stop believing in your vision.',
              date: '3 min ago',
              numOfLikes: 2450,
              profileImageUrl: getRandomProfileImage(0),
            ),
            const Divider(),
            notif.Notification(
              postId: 2,
              name: 'Warren Buffett',
              post: 'The Power of Compound Interest',
              description:
                  'Investing is simple: buy quality businesses at reasonable prices and hold them for the long term. Discipline and patience are the keys to building generational wealth.',
              date: '5 minutes ago',
              numOfLikes: 3120,
              profileImageUrl: getRandomProfileImage(1),
            ),
            const Divider(),
            notif.Notification(
              postId: 3,
              name: 'Elon Musk',
              post: 'The Future of Sustainable Energy',
              description:
                  'Our civilization must transition to renewable energy. Innovation and persistence can solve the greatest challenges facing humanity today.',
              date: '1 hour ago',
              numOfLikes: 2890,
              profileImageUrl: getRandomProfileImage(2),
            ),
            const Divider(),
            notif.Notification(
              postId: 4,
              name: 'Bill Gates',
              post: 'Global Health and Philanthropy',
              description:
                  'Technology can save lives and reduce inequality. We must invest in education and healthcare to uplift billions from poverty.',
              date: '2 hours ago',
              numOfLikes: 2765,
              profileImageUrl: getRandomProfileImage(3),
            ),
            const Divider(),
            notif.Notification(
              postId: 5,
              name: 'Jeff Bezos',
              post: 'Customer Obsession and Long-Term Thinking',
              description:
                  'Every decision must be driven by what\'s best for the customer. Think in decades, not quarters, and be willing to fail to innovate.',
              date: 'Yesterday',
              numOfLikes: 3340,
              profileImageUrl: getRandomProfileImage(4),
            ),
            const Divider(),
            notif.Notification(
              postId: 6,
              name: 'Oprah Winfrey',
              post: 'Building Your Authentic Brand',
              description:
                  'Success comes from knowing who you are and sharing your truth with the world. Your story is your superpower in business and life.',
              date: '2 days ago',
              numOfLikes: 2615,
              profileImageUrl: getRandomProfileImage(5),
            ),
            const Divider(),
            notif.Notification(
              postId: 7,
              name: 'Satya Nadella',
              post: 'Digital Transformation and Growth Mindset',
              description:
                  'Organizations must embrace a growth mindset and empower their people to innovate. The future belongs to those who adapt and learn continuously.',
              date: '3 days ago',
              numOfLikes: 2540,
              profileImageUrl: getRandomProfileImage(0),
            ),
            const Divider(),
            notif.Notification(
              postId: 8,
              name: 'Mary Barra',
              post: 'Leadership in the Electric Vehicle Revolution',
              description:
                  'The automotive industry is transforming. Leaders must embrace change and make bold decisions for a sustainable future.',
              date: 'Last week',
              numOfLikes: 2890,
              profileImageUrl: getRandomProfileImage(1),
            ),
            const Divider(),
            notif.Notification(
              postId: 9,
              name: 'Sheryl Sandberg',
              post: 'Leaning In: Women in Leadership',
              description:
                  'Women must claim their seat at the table. Ambition, resilience, and community are essential for breaking through barriers.',
              date: '2 weeks ago',
              numOfLikes: 2475,
              profileImageUrl: getRandomProfileImage(2),
            ),
            const Divider(),
            notif.Notification(
              postId: 10,
              name: 'Jack Ma',
              post: 'Entrepreneurship and Global Commerce',
              description:
                  'The internet has democratized opportunities for small businesses worldwide. Embrace the future, and remember that today\'s challenge is tomorrow\'s opportunity.',
              date: 'Last month',
              numOfLikes: 3265,
              profileImageUrl: getRandomProfileImage(3),
            ),
            const Divider(),
            notif.Notification(
              postId: 11,
              name: 'Tim Cook',
              post: 'Privacy, Ethics, and Technology',
              description: 'Technology companies have a moral responsibility to protect user privacy and promote ethical business practices in the digital age.',
              date: '2 months ago',
              numOfLikes: 2950,
              profileImageUrl: getRandomProfileImage(4),
            ),
          ],
        ),
      ),
    );
  }
}