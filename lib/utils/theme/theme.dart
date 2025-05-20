import 'package:flutter/material.dart';

import 'custom_theme/appBar_theme.dart';
import 'custom_theme/bottom_appBar_theme.dart';
import 'custom_theme/text_theme.dart';

class TSWTTheme {
  TSWTTheme._();

  //Light Theme
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF2F6F9),
      appBarTheme: TSWTAppBarTheme.lightAppBarTheme,
      bottomAppBarTheme: TSWTBottomAppBarTheme.lightAppBarTheme,
      textTheme: TSWTTextTheme.lightTextTheme);
  //Dark Theme
  static ThemeData darkTheme = ThemeData(
      // scaffoldBackgroundColor: Color(0xff1E1E1E),
    scaffoldBackgroundColor: const Color(0xff1E1E1E),
      appBarTheme: TSWTAppBarTheme.darkAppBarTheme,
      bottomAppBarTheme: TSWTBottomAppBarTheme.darkAppBarTheme,
      brightness: Brightness.dark,
      textTheme: TSWTTextTheme.darkTextTheme);
}
