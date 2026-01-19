import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show Provider;
import '../constants.dart';
import '../widgets/custom_font.dart';
import '../widgets/custom_button.dart';
import '../widgets/post_card.dart';
import '../providers/user_provider.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Image 
  final String profileImageUrl = 'assets/images/TupeDP.jpg'; 
  final String coverImageUrl = 'assets/images/JosePost.jpg';

  // Enhancement 2
  final String followersCount = '1.2M';
  final String followingCount = '328';

  @override
  Widget build(BuildContext context) {
    // get username from provider
    final userProvider = Provider.of<UserProvider>(context);
    final String profileName = userProvider.username;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: DecorationImage(
                              image: AssetImage(coverImageUrl),
                              fit: BoxFit.cover,
                            ),
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
                                backgroundImage: AssetImage(profileImageUrl),
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
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Enhancement 3: Profile name now comes from UserProvider
                          CustomFont(
                            text: profileName,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(20),
                            color: Colors.black,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(5)),
                          // Enhancement 2
                          Row(
                            children: [
                              CustomFont(
                                text: followersCount,
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              CustomFont(
                                text: 'followers',
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.grey,
                                fontWeight: FontWeight.w100,
                              ),
                              SizedBox(width: ScreenUtil().setWidth(5)),
                              Icon(
                                Icons.circle,
                                size: ScreenUtil().setSp(5),
                                color: Colors.grey,
                              ),
                              SizedBox(width: ScreenUtil().setWidth(5)),
                              CustomFont(
                                text: followingCount,
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              CustomFont(
                                text: 'following',
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.grey,
                                fontWeight: FontWeight.w100,
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          Row(
                            children: [
                              CustomButton(
                                buttonName: 'Follow',
                                onPressed: () {},
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              CustomButton(
                                buttonName: 'Message',
                                onPressed: () {},
                                buttonType: 'outlined',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _StickyTabBarDelegate(
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
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              // Enhancement 3: Posts Section with dynamic username
              _buildPostsSection(profileName),
              // Enhancement 4: About Section 
              _buildAboutSection(),
              // Enhancement 5: Photos Section 
              _buildPhotosSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Enhancement 3: Build Posts Section with dynamic username
  Widget _buildPostsSection(String profileName) {
    return ListView(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      children: [
        PostCard(
          userName: profileName,
          date: '2h ago',
          postContent: 'lodi ko yan',
          numOfLikes: 245,
          hasImage: true,
        ),
        PostCard(
          userName: profileName,
          date: '5h ago',
          postContent: 'my love belongs to you',
          numOfLikes: 189,
          hasImage: false,
        ),
        PostCard(
          userName: profileName,
          date: '1d ago',
          postContent: 'ah ganun ba,, gege.',
          numOfLikes: 312,
          hasImage: true,
        ),
        PostCard(
          userName: profileName,
          date: '2d ago',
          postContent: 'zgzg',
          numOfLikes: 156,
          hasImage: false,
        ),
        PostCard(
          userName: profileName,
          date: '3d ago',
          postContent: 'lalaland',
          numOfLikes: 421,
          hasImage: true,
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return ListView(
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      children: [
        _buildAboutItem(Icons.school, 'Studies at', 'National University - Manila'),
        _buildAboutItem(Icons.home, 'Lives in', 'Navotas City, Metro Manila'),
        _buildAboutItem(Icons.location_on, 'From', 'Philippines'),
        _buildAboutItem(Icons.favorite, 'Relationship', 'Taken'),
        _buildAboutItem(Icons.cake, 'Birthday', 'March 2, 2004'),
        SizedBox(height: ScreenUtil().setHeight(20)),
      ],
    );
  }

  Widget _buildAboutItem(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
      child: Row(
        children: [
          Icon(icon, size: ScreenUtil().setSp(24), color: Colors.grey[700]),
          SizedBox(width: ScreenUtil().setWidth(15)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFont(
                text: label,
                fontSize: ScreenUtil().setSp(12),
                color: Colors.grey,
              ),
              CustomFont(
                text: value,
                fontSize: ScreenUtil().setSp(14),
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosSection() {
    final List<String> photoUrls = List.generate(
      6,
      (index) => 'assets/images/TupeDP.jpg',
    );

    return GridView.builder(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: ScreenUtil().setWidth(5),
        mainAxisSpacing: ScreenUtil().setHeight(5),
      ),
      itemCount: photoUrls.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            image: DecorationImage(
              image: AssetImage(photoUrls[index]), 
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8), 
          ),
        );
      },
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}