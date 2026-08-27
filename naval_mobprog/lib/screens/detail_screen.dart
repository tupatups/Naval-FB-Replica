import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:naval_mobprog/constants.dart';
import 'package:naval_mobprog/widgets/custom_font.dart';
import '../services/post_service.dart';
import '../models/comment.dart';

class DetailScreen extends StatefulWidget {
  final int postId; // NEW
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final String imageUrl;
  final String profileImageUrl;

  const DetailScreen({
    super.key,
    required this.postId,
    required this.userName,
    required this.postContent,
    this.numOfLikes = 0,
    required this.date,
    this.imageUrl = '',
    this.profileImageUrl = '',
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late int numOfLikes;
  bool isLiked = false;

  final PostService _postService = PostService();
  List<Comment> _comments = [];
  bool _isLoadingComments = true;

  final TextEditingController _commentController = TextEditingController();
  int? currentUserId;

  @override
  void initState() {
    super.initState();
    numOfLikes = widget.numOfLikes;
    _fetchComments();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getInt('id') ?? 1;
  }

  Future<void> _fetchComments() async {
    try {
      final comments = await _postService.getPostComments(widget.postId);
      setState(() {
        _comments = comments;
        _isLoadingComments = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingComments = false;
      });
    }
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        numOfLikes--;
        isLiked = false;
      } else {
        numOfLikes++;
        isLiked = true;
      }
    });
  }

  Future<void> _submitComment() async {
    if (_commentController.text.trim().isEmpty) return;

    String text = _commentController.text;
    _commentController.clear();
    FocusScope.of(context).unfocus();

    try {
      Comment newComment = await _postService.addComment(
        widget.postId,
        currentUserId!,
        text,
      );

      setState(() {
        _comments.add(newComment);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to post comment')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        title: CustomFont(
          text: widget.userName,
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (widget.imageUrl != '') Image.network(widget.imageUrl),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (widget.profileImageUrl == '')
                            ? const Icon(Icons.person, size: 40)
                            : CircleAvatar(
                                radius: ScreenUtil().setSp(20),
                                backgroundImage: NetworkImage(
                                  widget.profileImageUrl,
                                ),
                              ),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFont(
                              text: widget.userName,
                              fontSize: ScreenUtil().setSp(18),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomFont(
                              text: widget.date,
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                    ),
                    alignment: Alignment.centerLeft,
                    child: CustomFont(
                      text: widget.postContent,
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: _toggleLike,
                          icon: Icon(
                            isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                            color: FB_DARK_PRIMARY,
                          ),
                          label: CustomFont(
                            text: numOfLikes.toString(),
                            fontSize: ScreenUtil().setSp(14),
                            color: FB_DARK_PRIMARY,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.comment,
                            color: FB_DARK_PRIMARY,
                          ),
                          label: CustomFont(
                            text: '${_comments.length} Comments',
                            fontSize: ScreenUtil().setSp(14),
                            color: FB_DARK_PRIMARY,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 5, color: Colors.grey[200]),

                  // comment section
                  _isLoadingComments
                      ? const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _comments.length,
                          itemBuilder: (context, index) {
                            final comment = _comments[index];
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Text(
                                comment.username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(comment.body),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),

          // comment textfield
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 10.h,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: FB_DARK_PRIMARY),
                  onPressed: _submitComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}