import 'package:mypos/utils/constant.dart';
import 'package:flutter/material.dart';

class MyPosTheme {
  static ThemeData defaultTheme() {
    return ThemeData(
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        foregroundColor: Colors.black,
      ),
      primaryColor: kDefaultGreen,
      scaffoldBackgroundColor: kDefaultBackgroundColor,
    );
  }
}
