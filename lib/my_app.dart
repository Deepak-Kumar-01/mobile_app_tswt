import 'package:flutter/material.dart';
import 'package:mobile_app_tswt/utils/theme/theme.dart';
import 'components/home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TSWTTheme.lightTheme,
      darkTheme: TSWTTheme.darkTheme,
      home:Home(isFirstTime: true,),
    );
  }
}
