import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'custom_font.dart';

class PostCard extends StatelessWidget {  
  final String userName;
  final String date;
  final String postContent;
  final int numOfLikes;
  final bool hasImage;

  const PostCard({  
    super.key,
    required this.userName,
    required this.date,
    required this.postContent,
    required this.numOfLikes,
    this.hasImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      padding: EdgeInsets.all(ScreenUtil().setSp(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setSp(20),
                    backgroundImage: const AssetImage(
                      'assets/images/TupeDP.jpg',
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: userName,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      CustomFont(
                        text: date,
                        fontSize: ScreenUtil().setSp(12),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.more_horiz),
            ],
          ),

          SizedBox(height: ScreenUtil().setHeight(10)),

          // Post Content Text
          CustomFont(
            text: postContent,
            fontSize: ScreenUtil().setSp(14),
            color: Colors.black,
          ),

          SizedBox(height: ScreenUtil().setHeight(10)),
          if (hasImage)
            Container(
              height: ScreenUtil().setHeight(200),
              width: double.infinity,
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/JosePost.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.thumb_up, size: 16, color: FB_PRIMARY),
                  SizedBox(width: 5),
                  CustomFont(
                    text: numOfLikes.toString(),
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ],
              ),
              CustomFont(
                text: "42 Comments  5 Shares",
                fontSize: 12,
                color: Colors.grey,
              ),
            ],
          ),

          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                },
                icon: const Icon(
                  Icons
                      .thumb_up_alt_outlined, 
                  color: Colors.grey,
                ),
                label: CustomFont(
                  text: 'Like',
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.comment_outlined, color: Colors.grey),
                label: CustomFont(
                  text: 'Comment',
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined, color: Colors.grey),
                label: CustomFont(
                  text: 'Share',
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              CircleAvatar(
                radius: ScreenUtil().setSp(15),
                backgroundImage: const AssetImage('assets/images/JoseDP.jpg'),
              ),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(10), 0, 0, 0),
                alignment: Alignment.centerLeft,
                height: ScreenUtil().setHeight(35), // Adjusted slightly for fit
                width: ScreenUtil().setWidth(
                  250,
                ), // Adjusted to fit screen width
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setSp(20)),
                  ),
                ),
                child: CustomFont(
                  text: 'Write a comment...',
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}