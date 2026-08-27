import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/auth_service.dart';
import '../widgets/custom_font.dart';
import '../widgets/custom_inkwell_button.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool pushNotifications = true;

  void _signOut() async {
    await AuthService().logout();

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: CustomFont(
          text: 'Settings & Privacy',
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        children: [
          CustomFont(
            text: 'Preferences',
            fontSize: ScreenUtil().setSp(18),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          SwitchListTile(
            title: CustomFont(
              text: 'Dark Mode',
              fontSize: 16.sp,
              color: Colors.black,
            ),
            value: isDarkMode,
            activeColor: Colors.blue,
            onChanged: (bool value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
          SwitchListTile(
            title: CustomFont(
              text: 'Push Notifications',
              fontSize: 16.sp,
              color: Colors.black,
            ),
            value: pushNotifications,
            activeColor: Colors.blue,
            onChanged: (bool value) {
              setState(() {
                pushNotifications = value;
              });
            },
          ),
          SizedBox(height: ScreenUtil().setHeight(40)),
          CustomInkwellButton(
            onTap: _signOut,
            height: ScreenUtil().setHeight(48),
            width: double.infinity,
            buttonName: 'Sign Out',
            fontSize: ScreenUtil().setSp(16),
          ),
        ],
      ),
    );
  }
}