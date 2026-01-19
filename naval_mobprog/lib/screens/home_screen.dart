import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naval_mobprog/screens/custom_info.dart';
import '../constants.dart';
import '../screens/newsfeed_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/custom_font.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  String get _appBarTitle {
    switch (_selectedIndex) {
      case 0:
        return 'LavanBook'; 
      case 1:
        return 'Notifications';
      case 2:
        return 'Christopher Naval';
      default:
        return 'Naval Social';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: FB_TEXT_COLOR_WHITE,
        elevation: 2,
        title: CustomFont(
          text: _appBarTitle, 
          fontSize: ScreenUtil().setSp(25),
          color: FB_DARK_PRIMARY,
          fontFamily: 'Klavika', 
          fontWeight: FontWeight.bold,
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          NewsFeedScreen(),
          NotificationsScreen(),
          ProfileScreen(), 
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
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: FB_PRIMARY,
        unselectedItemColor: Colors.grey, 
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}