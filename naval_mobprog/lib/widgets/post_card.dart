import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'custom_font.dart';
import '../screens/detail_screen.dart'; 

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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              userName: userName,
              postContent: postContent, 
              date: date,
              numOfLikes: numOfLikes,
              imageUrl: hasImage ? 'assets/images/JosePost.jpg' : '',
              profileImageUrl: 'assets/images/TupeDP.jpg', 
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10),
          vertical: ScreenUtil().setHeight(8),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
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
                        radius: ScreenUtil().setSp(22),
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
                            fontSize: ScreenUtil().setSp(17),
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          Row(
                            children: [
                              CustomFont(
                                text: date,
                                fontSize: ScreenUtil().setSp(13),
                                color: Colors.grey.shade600,
                              ),
                              SizedBox(width: ScreenUtil().setWidth(4)),
                              Icon(
                                Icons.public,
                                size: ScreenUtil().setSp(14),
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.more_horiz, color: Colors.grey.shade700, size: 24),
                ],
              ),

              SizedBox(height: ScreenUtil().setHeight(12)),

              // Post Content Text
              CustomFont(
                text: postContent,
                fontSize: ScreenUtil().setSp(15),
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),

              SizedBox(height: ScreenUtil().setHeight(12)),
              
              if (hasImage)
                Container(
                  height: ScreenUtil().setHeight(200),
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/JosePost.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              
              // Likes and Comments Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: FB_PRIMARY,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.thumb_up,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      CustomFont(
                        text: numOfLikes.toString(),
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  CustomFont(
                    text: "42 Comments  5 Shares",
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
                child: Divider(thickness: 0.8, color: Colors.grey.shade300),
              ),

              // Action Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    icon: Icons.thumb_up_alt_outlined,
                    label: 'Like',
                    onTap: () {},
                  ),
                  _buildActionButton(
                    icon: Icons.chat_bubble_outline,
                    label: 'Comment',
                    onTap: () {},
                  ),
                  _buildActionButton(
                    icon: Icons.redo,
                    label: 'Share',
                    onTap: () {},
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
                child: Divider(thickness: 0.8, color: Colors.grey.shade300),
              ),

              // Comment Input Row
              Row(
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setSp(16),
                    backgroundImage: const AssetImage('assets/images/JoseDP.jpg'),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setSp(15),
                        vertical: ScreenUtil().setSp(10),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomFont(
                        text: 'Write a comment...',
                        fontSize: ScreenUtil().setSp(13),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(8),
          vertical: ScreenUtil().setHeight(6),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey.shade700,
              size: ScreenUtil().setSp(20),
            ),
            SizedBox(width: ScreenUtil().setWidth(6)),
            CustomFont(
              text: label,
              fontSize: ScreenUtil().setSp(14),
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}