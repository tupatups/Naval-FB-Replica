import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naval_mobprog/screens/profile_screen.dart';
import 'package:provider/provider.dart'; // NEW: Import provider
import 'package:naval_mobprog/screens/detail_screen.dart';
import 'package:naval_mobprog/screens/login_screen.dart';
import 'package:naval_mobprog/screens/register_Screen.dart';
import 'screens/home_screen.dart';
import 'screens/newsfeed_screen.dart';
import 'providers/user_provider.dart'; // NEW: Import UserProvider

void main() => runApp(const NavalFacebook());

class NavalFacebook extends StatelessWidget {
  const NavalFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    // NEW: Wrap the app with ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: ScreenUtilInit(
        designSize: const Size(412, 715),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Facebook Replication',
            initialRoute: '/login',
            routes: {
              '/newsfeed': (context) => const NewsFeedScreen(),
              '/home': (context) => const HomeScreen(),
              '/detail': (context) => DetailScreen(userName: '', postContent: '', date: '',),
              '/login': (context) => const LogInScreen(),
              '/register': (context) => const RegisterScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}