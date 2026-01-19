import 'package:naval_mobprog/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_font.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  final String userName;
  final String postContent;
  final String date;
  int numOfLikes;
  final String imageUrl;
  final String profileImageUrl;

  DetailScreen({
    super.key,
    required this.userName,
    required this.postContent,
    this.numOfLikes = 0,
    required this.date,
    this.imageUrl = 'assets/images/golden.jpg',
    this.profileImageUrl = 'assets/images/TupeDP.jpg',
  });

  @override
  Widget build(BuildContext context) {
    bool isLiked = false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomFont(
          text: userName,
          fontSize: ScreenUtil().setSp(18),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              
              if (imageUrl.isNotEmpty)
                Image.asset(
                  imageUrl,
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().setHeight(350),
                  fit: BoxFit.cover,
                ),

              SizedBox(height: ScreenUtil().setHeight(15)),

              // PROFILE HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: ScreenUtil().setSp(22),
                      backgroundImage: AssetImage(profileImageUrl),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          CustomFont(
                            text: userName,
                            fontSize: ScreenUtil().setSp(16),
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
                    ),
                    const Icon(Icons.more_horiz, color: Colors.grey),
                  ],
                ),
              ),

              SizedBox(height: ScreenUtil().setHeight(12)),

              // CAPTION 
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                child: CustomFont(
                  text: postContent, 
                  fontSize: ScreenUtil().setSp(15),
                  color: Colors.black,
                ),
              ),

              SizedBox(height: ScreenUtil().setHeight(15)),
              const Divider(thickness: 0.5),

              // INTERACTION 
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  int displayLikes = isLiked ? (numOfLikes + 1) : numOfLikes;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Like Button
                        _buildActionButton(
                          icon: Icons.thumb_up_outlined,
                          label: displayLikes == 0 ? "Like" : "$displayLikes",
                          color: isLiked ? FB_DARK_PRIMARY : Colors.grey.shade700,
                          onTap: () => setState(() => isLiked = !isLiked),
                        ),
                        // Comment Button
                        _buildActionButton(
                          icon: Icons.chat_bubble_outline,
                          label: "Comment",
                          color: Colors.grey.shade700,
                          onTap: () {},
                        ),
                        // Share Button
                        _buildActionButton(
                          icon: Icons.redo,
                          label: "Share",
                          color: Colors.grey.shade700,
                          onTap: () {},
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(thickness: 0.5),
            ],
          ),
        ),
      ),
    );
  }

  //
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
        child: Row(
          children: [
            Icon(icon, size: ScreenUtil().setSp(18), color: color),
            SizedBox(width: ScreenUtil().setWidth(5)),
            CustomFont(text: label, fontSize: ScreenUtil().setSp(13), color: color),
          ],
        ),
      ),
    );
  }
}