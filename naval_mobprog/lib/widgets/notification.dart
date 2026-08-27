import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naval_mobprog/screens/detail_screen.dart';
import 'package:naval_mobprog/widgets/custom_font.dart' show CustomFont;

class Notification extends StatelessWidget {
  const Notification({
    super.key,
    required this.postId, // Added required postId
    required this.name,
    required this.post,
    required this.description,
    this.icon = const Icon(Icons.person),
    this.profileImageUrl = '',
    this.atProfile = false,
    required this.date,
    this.imageUrl = '',
    required this.numOfLikes,
  });

  final int postId; // Added postId
  final String name;
  final String post;
  final String description;
  final Icon icon;
  final String profileImageUrl;
  final String date;
  final int numOfLikes;
  final String imageUrl;
  final bool atProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setSp(10)),
      child: InkWell(
        onTap: () {
          (atProfile)
              ? print('')
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      postId: postId, // Pass the postId to DetailScreen
                      userName: name,
                      postContent: description,
                      date: date,
                      numOfLikes: numOfLikes,
                      imageUrl: imageUrl,
                      profileImageUrl: profileImageUrl,
                    ),
                  ),
                );
        },
        child: Row(
          children: [
            (profileImageUrl == '')
                ? CircleAvatar(radius: ScreenUtil().setSp(25), child: icon)
                : CircleAvatar(
                    radius: ScreenUtil().setSp(25),
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: name,
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                    CustomFont(
                      text: 'Posted: $post',
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                    CustomFont(
                      text: description,
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      overflow: TextOverflow.ellipsis,
                    ),
                    CustomFont(
                      text: date,
                      fontSize: ScreenUtil().setSp(9),
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ),
            const Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}