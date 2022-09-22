// @dart=2.9

import 'package:gapura/constants.dart';
import 'package:gapura/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _StateMyApp();
}

class _StateMyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gapura CMS',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme:
            GoogleFonts.signikaNegativeTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: fontColor),
        canvasColor: secondaryColor,
      ),
      home: LoginScreen(),
    );
  }
}
