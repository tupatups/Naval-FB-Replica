import 'package:shared_preferences/shared_preferences.dart';
import 'package:naval_mobprog/services/auth_service.dart';
import 'package:naval_mobprog/widgets/custom_inkwell_button.dart';
import 'package:naval_mobprog/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().setHeight(40),
                  color: FB_DARK_PRIMARY,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(25),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/NUCCITLogo_Black.png',
                        height: ScreenUtil().setHeight(200),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(30)),
                      CustomTextFormField(
                        height: ScreenUtil().setHeight(10),
                        width: ScreenUtil().setWidth(10),
                        controller: usernameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your username' : null,
                        onSaved: (value) {},
                        fontColor: FB_DARK_PRIMARY,
                        fontSize: ScreenUtil().setSp(15),
                        hintText: 'Username',
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      CustomTextFormField(
                        height: ScreenUtil().setHeight(10),
                        width: ScreenUtil().setWidth(10),
                        controller: passwordController,
                        isObscure: true,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your password' : null,
                        onSaved: (value) {},
                        fontSize: ScreenUtil().setSp(15),
                        fontColor: FB_DARK_PRIMARY,
                        hintTextSize: ScreenUtil().setSp(15),
                        hintText: 'Password',
                      ),
                      SizedBox(height: ScreenUtil().setHeight(50)),
                      _isLoading
                          ? Container(
                              height: ScreenUtil().setHeight(48),
                              width: ScreenUtil().screenWidth,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: FB_DARK_PRIMARY,
                                borderRadius: BorderRadius.circular(
                                  ScreenUtil().setSp(8),
                                ),
                              ),
                              child: SizedBox(
                                height: ScreenUtil().setHeight(22),
                                width: ScreenUtil().setWidth(22),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : CustomInkwellButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  setState(() {
                                    _isLoading = true;
                                  });

                                  AuthService authService = AuthService();
                                  bool success = await authService.login(
                                    usernameController.text,
                                    passwordController.text,
                                  );

                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });

                                    if (success) {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      final savedUsername = prefs.getString(
                                        'username',
                                      );

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                            username:
                                                savedUsername ??
                                                usernameController.text,
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Invalid username or password.',
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              height: ScreenUtil().setHeight(48),
                              width: ScreenUtil().screenWidth,
                              buttonName: 'Login',
                              fontSize: ScreenUtil().setSp(15),
                            ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().setHeight(40),
                  color: FB_DARK_PRIMARY,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You do not have an account ? ',
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: ScreenUtil().setSp(15),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.popAndPushNamed(context, '/register'),
                        child: Text(
                          'Register here',
                          style: TextStyle(
                            color: FB_LIGHT_PRIMARY,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}