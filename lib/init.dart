import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  //device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //Hive setup
  final appDocDir = await getApplicationDocumentsDirectory();
  final customPath = Directory('${appDocDir.path}/TSWT');
  if (!await customPath.exists()) {
    await customPath.create(recursive: true);
  }
  Hive.init(customPath.path);
  // Hive check
  // await PrefManager.db.init();
  // bool loggedIn = PrefManager.db.isLoggedIn;
  // print("LoggedIn: ${loggedIn}");
  // await PrefManager.db.setIsLoggedIn(false);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Phoenix(child: const MyApp()));
}
