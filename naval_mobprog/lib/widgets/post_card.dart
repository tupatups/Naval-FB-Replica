import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../screens/detail_screen.dart';
import '../constants.dart';
import 'custom_font.dart';

// ignore: must_be_immutable
class PostCard extends StatefulWidget {
  final int postId; // NEW parameter
  final String userName;
  final String postContent;
  final String date;
  final String imageUrl;
  int numOfLikes;
  final String profileImageUrl;
  final String adsMarket;

  PostCard({
    super.key,
    required this.postId, // Required here
    required this.userName,
    required this.postContent,
    required this.date,
    this.imageUrl = '',
    this.numOfLikes = 0,
    this.profileImageUrl = '',
    this.adsMarket = '',
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false; // Added to track like state locally

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              postId: widget.postId, // Pass it to detail screen
              userName: widget.userName,
              postContent: widget.postContent,
              date: widget.date,
              numOfLikes: widget.numOfLikes,
              imageUrl: widget.imageUrl,
              profileImageUrl: widget.profileImageUrl,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(ScreenUtil().setSp(10)),
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setSp(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (widget.profileImageUrl == '')
                      ? const Icon(Icons.person)
                      : ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                            imageUrl: widget.profileImageUrl,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: FB_DARK_PRIMARY,
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, size: 40.sp),
                          ),
                        ),
                  SizedBox(width: ScreenUtil().setWidth(13)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: widget.userName,
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomFont(
                            text: widget.date,
                            fontSize: ScreenUtil().setSp(12),
                            color: Colors.grey,
                          ),
                          SizedBox(width: ScreenUtil().setWidth(3)),
                          Icon(
                            Icons.public,
                            color: Colors.grey,
                            size: ScreenUtil().setSp(15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.more_horiz),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              CustomFont(
                text: widget.postContent,
                fontSize: ScreenUtil().setSp(14),
                color: Colors.black,
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              if (widget.imageUrl != '')
                CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                          color: FB_DARK_PRIMARY,
                          value: downloadProgress.progress,
                        ),
                      ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, size: 100.sp),
                ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Clickable Like functionality
                      setState(() {
                        if (isLiked) {
                          widget.numOfLikes--;
                        } else {
                          widget.numOfLikes++;
                        }
                        isLiked = !isLiked;
                      });
                    },
                    icon: Icon(
                      isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color: FB_DARK_PRIMARY,
                    ),
                    label: CustomFont(
                      text: (widget.numOfLikes == 0)
                          ? 'Like'
                          : widget.numOfLikes.toString(),
                      fontSize: ScreenUtil().setSp(12),
                      color: FB_DARK_PRIMARY,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.comment, color: FB_DARK_PRIMARY),
                    label: CustomFont(
                      text: 'Comment',
                      fontSize: ScreenUtil().setSp(12),
                      color: FB_DARK_PRIMARY,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.redo, color: FB_DARK_PRIMARY),
                    label: CustomFont(
                      text: 'Share',
                      fontSize: ScreenUtil().setSp(12),
                      color: FB_DARK_PRIMARY,
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
}