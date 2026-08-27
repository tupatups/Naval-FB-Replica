import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_font.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? username;
  const ProfileScreen({super.key, this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PostService _postService = PostService();
  late Future<List<Post>> _userPostsFuture;

  String displayName = 'Loading...';
  String profileImageUrl = '';
  int? userId;

  @override
  void initState() {
    super.initState();
    _userPostsFuture = Future.value([]); 
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Use user ID 2 for fetching posts
      userId = 2;
      String fName = prefs.getString('firstName') ?? '';
      String lName = prefs.getString('lastName') ?? '';
      displayName = fName.isNotEmpty
          ? '$fName $lName'
          : (widget.username ?? 'User Profile');

      // Use local asset image for profile
      profileImageUrl = 'assets/images/TupeDP.jpg';

      if (userId != null) {
        _userPostsFuture = _postService.getUserPosts(userId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/golden.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: ScreenUtil().setWidth(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: ClipOval(
                            child: profileImageUrl.isEmpty
                                ? const Icon(Icons.person, size: 50)
                                : Image.asset(
                                    profileImageUrl,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(55)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: displayName,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(20),
                      color: Colors.black,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    Row(
                      children: [
                        CustomFont(
                          text: '100M',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'followers',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.grey,
                          fontWeight: FontWeight.w100,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: '56',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'following',
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.grey,
                          fontWeight: FontWeight.w100,
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setSp(10)),
                    Row(
                      children: [
                        CustomButton(buttonName: 'Follow', onPressed: () {}),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        CustomButton(
                          buttonName: 'Message',
                          onPressed: () {},
                          buttonType: 'outlined',
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10)),

                        // Settings Button added here
                        IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              TabBar(
                indicatorColor: FB_DARK_PRIMARY,
                tabs: [
                  Tab(
                    child: CustomFont(
                      text: 'Posts',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    child: CustomFont(
                      text: 'About',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    child: CustomFont(
                      text: 'Photos',
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(2000),
                child: TabBarView(
                  children: [
                    // Dynamic Posts Tab
                    FutureBuilder<List<Post>>(
                      future: _userPostsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: FB_DARK_PRIMARY,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error loading posts.'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No posts found.'));
                        }

                        final posts = snapshot.data!;

                        
                        return ListView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), 
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return PostCard(
                              postId: post.id,
                              userName: displayName,
                              postContent: post.body,
                              date:
                                  'Just now', 
                              numOfLikes: post.likes,
                              profileImageUrl: profileImageUrl,
                            );
                          },
                        );
                      },
                    ),

                    // About Tab (Unchanged)
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                20,
                                16,
                                12,
                              ),
                              child: CustomFont(
                                text: 'Details',
                                fontSize: ScreenUtil().setSp(20),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.book,
                                    color: Colors.grey[600],
                                    size: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  CustomFont(
                                    text: 'National University Manila',
                                    fontSize: ScreenUtil().setSp(15),
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cake,
                                    color: Colors.grey[600],
                                    size: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  CustomFont(
                                    text: 'August 11, 2004',
                                    fontSize: ScreenUtil().setSp(15),
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: Colors.grey[600],
                                    size: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  CustomFont(
                                    text: 'Youtube, NASA, SpaceX, Tesla',
                                    fontSize: ScreenUtil().setSp(15),
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.more_horiz,
                                    color: Colors.grey[600],
                                    size: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  CustomFont(
                                    text: 'See $displayName\'s About info',
                                    fontSize: ScreenUtil().setSp(15),
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                    
                    GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(5),
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 3,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/cat.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/owl.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/binimikha.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/JosePost.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/golden.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}