import '../constants.dart';
import '../widgets/custom_font.dart';
import '../widgets/custom_inkwell_button.dart';
import '../widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart'; // NEW: Import provider

import '../widgets/custom_dialogs.dart';
import '../providers/user_provider.dart'; // NEW: Import UserProvider

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobilenumController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  // ENHANCEMENT 2: Custom Validation Method
  void register() {
    // Check if all fields are filled
    if (firstnameController.text.isEmpty ||
        lastnameController.text.isEmpty ||
        mobilenumController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmpasswordController.text.isEmpty) {
      customDialog(
        context,
        title: 'Error',
        content: 'All fields are required to continue.',
      );
      return;
    }

    // Validate first name (no numbers, minimum 2 characters)
    if (firstnameController.text.length < 2) {
      customDialog(
        context,
        title: 'Error',
        content: 'First name must be at least 2 characters long.',
      );
      return;
    }

    if (RegExp(r'[0-9]').hasMatch(firstnameController.text)) {
      customDialog(
        context,
        title: 'Error',
        content: 'First name should not contain numbers.',
      );
      return;
    }

    // Validate last name (no numbers, minimum 2 characters)
    if (lastnameController.text.length < 2) {
      customDialog(
        context,
        title: 'Error',
        content: 'Last name must be at least 2 characters long.',
      );
      return;
    }

    if (RegExp(r'[0-9]').hasMatch(lastnameController.text)) {
      customDialog(
        context,
        title: 'Error',
        content: 'Last name should not contain numbers.',
      );
      return;
    }

    // Validate mobile number (must be exactly 11 digits)
    if (mobilenumController.text.length != 11) {
      customDialog(
        context,
        title: 'Error',
        content: 'The mobile number must be 11 digit.',
      );
      return;
    }

    // Check if mobile number contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(mobilenumController.text)) {
      customDialog(
        context,
        title: 'Error',
        content: 'Mobile number must contain only numbers.',
      );
      return;
    }

    // Optional: Check if mobile number starts with 09
    if (!mobilenumController.text.startsWith('09')) {
      customDialog(
        context,
        title: 'Error',
        content: 'Mobile number must start with 09.',
      );
      return;
    }

    // Validate password requirements
    String password = passwordController.text;
    
    if (password.length < 8) {
      customDialog(
        context,
        title: 'Error',
        content: 'Password should be 8 characters, a mixture of letter and numbers consisting of at least one special character with Uppercase and Lowercase letters.',
      );
      return;
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      customDialog(
        context,
        title: 'Error',
        content: 'Password should be 8 characters, a mixture of letter and numbers consisting of at least one special character with Uppercase and Lowercase letters.',
      );
      return;
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      customDialog(
        context,
        title: 'Error',
        content: 'Password should be 8 characters, a mixture of letter and numbers consisting of at least one special character with Uppercase and Lowercase letters.',
      );
      return;
    }

    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      customDialog(
        context,
        title: 'Error',
        content: 'Password should be 8 characters, a mixture of letter and numbers consisting of at least one special character with Uppercase and Lowercase letters.',
      );
      return;
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      customDialog(
        context,
        title: 'Error',
        content: 'Password should be 8 characters, a mixture of letter and numbers consisting of at least one special character with Uppercase and Lowercase letters.',
      );
      return;
    }

    // Validate password confirmation
    if (passwordController.text != confirmpasswordController.text) {
      customDialog(
        context,
        title: 'Error',
        content: 'Password and Confirm Password do not match.',
      );
      return;
    }

    // If all validations pass, save user and navigate directly to home
    // NEW: Save the registered username/firstname to provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    // You can use either username or combine first name and last name
    String fullName = '${firstnameController.text} ${lastnameController.text}';
    userProvider.setUsername(fullName);
    
    // Show success dialog and navigate to home
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Registration successful! Welcome ${firstnameController.text}!'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Continue'),
              style: ElevatedButton.styleFrom(
                backgroundColor: FB_DARK_PRIMARY,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/profile'); 
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(25),
            ScreenUtil().setHeight(40),
            ScreenUtil().setWidth(25),
            ScreenUtil().setHeight(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
              CustomFont(
                text: 'Register Here',
                fontSize: ScreenUtil().setSp(50),
                fontWeight: FontWeight.bold,
                color: FB_DARK_PRIMARY,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
              CustomTextFormField(
                height: ScreenUtil().setHeight(10),
                width: ScreenUtil().setWidth(10),
                onSaved: null,
                fontColor: null,
                hintText: 'First name',
                validator: (value) => null,
                hintTextSize: ScreenUtil().setSp(15),
                fontSize: ScreenUtil().setSp(15),
                controller: firstnameController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFormField(
                height: ScreenUtil().setHeight(10),
                width: ScreenUtil().setWidth(10),
                onSaved: null,
                fontColor: null,
                hintText: 'Last name',
                validator: (value) => null,
                hintTextSize: ScreenUtil().setSp(15),
                fontSize: ScreenUtil().setSp(15),
                controller: lastnameController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFormField(
                maxLength: 11,
                keyboardType: TextInputType.number,
                height: ScreenUtil().setHeight(10),
                width: ScreenUtil().setWidth(10),
                onSaved: null,
                fontColor: null,
                hintText: 'Mobile Num',
                validator: (value) => null,
                hintTextSize: ScreenUtil().setSp(15),
                fontSize: ScreenUtil().setSp(15),
                controller: mobilenumController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFormField(
                isObscure: true,
                isPassword: true,
                height: ScreenUtil().setHeight(10),
                width: ScreenUtil().setWidth(10),
                onSaved: null,
                fontColor: null,
                hintText: 'Password',
                validator: (value) => null,
                hintTextSize: ScreenUtil().setSp(15),
                fontSize: ScreenUtil().setSp(15),
                controller: passwordController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                '(Password should be 8 characters, a mixture of letter and numbers consisting of at least one special character with Uppercase and Lowercase letters.)',
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: ScreenUtil().setSp(10)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFormField(
                isObscure: true,
                isPassword: true,
                hintText: 'Confirm Password',
                height: ScreenUtil().setHeight(10),
                width: ScreenUtil().setWidth(10),
                onSaved: null,
                fontColor: null,
                validator: (value) => null,
                hintTextSize: ScreenUtil().setSp(15),
                fontSize: ScreenUtil().setSp(15),
                controller: confirmpasswordController,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You have an account? ',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: ScreenUtil().setSp(15)),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.popAndPushNamed(context, '/login'),
                    child: Text(
                      'Login here',
                      style: TextStyle(
                        color: FB_DARK_PRIMARY,
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomInkwellButton(
                onTap: () => register(),
                height: ScreenUtil().setHeight(45),
                width: ScreenUtil().screenWidth,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.bold,
                buttonName: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}