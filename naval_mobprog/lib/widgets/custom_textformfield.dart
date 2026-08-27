// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/services.dart';
import '../constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.validator,
    required this.onSaved,
    this.controller,
    this.isObscure = false,
    required this.fontSize,
    required this.fontColor,
    this.hintTextSize = 12.0,
    this.hintText = '',
    this.fillColor = Colors.black12,
    required this.height,
    required this.width,
    this.keyboardType = TextInputType.text,
    this.maxLength = 200,
    this.isPassword = false, // NEW: Flag to enable password toggle
  });

  final validator;
  final onSaved;
  final controller;
  final bool isObscure;
  final double fontSize;
  final fontColor;
  final double height, width;
  final double hintTextSize;
  final String hintText;
  final fillColor;
  TextInputType keyboardType;
  int maxLength;
  final bool isPassword; 

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isPasswordVisible; // state for password visibility

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = !widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onSaved: widget.onSaved,
      controller: widget.controller,
      obscureText: widget.isPassword ? !_isPasswordVisible : widget.isObscure, 
      keyboardType: widget.keyboardType,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxLength),
      ],
      style: TextStyle(
        fontSize: widget.fontSize,
        color: widget.fontColor,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
            widget.width, widget.height, widget.width, widget.height),
        focusColor: Colors.black12,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: FB_DARK_PRIMARY,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: FB_DARK_PRIMARY,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        errorStyle: const TextStyle(fontFamily: 'Frutiger'),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: FB_PRIMARY,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.black12,
          fontSize: widget.hintTextSize,
          fontFamily: 'Frutiger',
        ),
        hintText: widget.hintText,
        fillColor: widget.fillColor,
      ),
    );
  }
}