import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naval_mobprog/constants.dart';
import 'package:naval_mobprog/screens/newsfeed_screen.dart';
import 'package:naval_mobprog/screens/notification_screen.dart';
import 'package:naval_mobprog/screens/profile_screen.dart';
import 'package:naval_mobprog/widgets/custom_font.dart';
import 'package:naval_mobprog/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? username;
  const HomeScreen({super.key, this.username});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String title = 'FishBook';
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: FB_TEXT_COLOR_WHITE,
        elevation: 2,
        title: CustomFont(
          text: _setTitle(_selectedIndex),
          fontSize: ScreenUtil().setSp(25),
          color: FB_PRIMARY,
          fontFamily: 'Klavika',
        ),
        // 2. Add the Settings action button here
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: FB_PRIMARY),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          const NewsfeedScreen(),
          const NotificationScreen(),
          ProfileScreen(username: widget.username),
        ],
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onTappedBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
        selectedItemColor: FB_PRIMARY,
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  String _setTitle(int value) {
    if (value == 1) {
      return 'Notifications';
    }

    if (value == 2) {
      return widget.username ?? 'Profile';
    }

    return 'FishBook';
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}