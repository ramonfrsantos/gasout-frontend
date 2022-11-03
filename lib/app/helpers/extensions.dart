import 'package:flutter/material.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this);
  }
}

const Color shrineBlack100 = Color(0xFF2c2f33);
const Color shrineBlack400 = Color(0xFF23272a);
const Color shrinePurple900 = Color(0xFF7289da);
const Color shrineErrorRed = Colors.red;
const Color shrineSurfaceWhite = Color(0xFFe9e9e9);
const Color shrineBackgroundWhite = Colors.white;
const defaultLetterSpacing = 0.03;
