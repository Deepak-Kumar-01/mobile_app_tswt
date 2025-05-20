import 'package:flutter/material.dart';

class TSWTTextTheme {
  TSWTTextTheme._();

  static TextTheme lightTextTheme = const TextTheme(
    titleLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  );
  static TextTheme darkTextTheme =  TextTheme(
    titleLarge: const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      // color: Color(0xffA5A7A8),
      color: Colors.yellow[300],
      fontSize: 14,
    ),
  );
}
