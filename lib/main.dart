import 'package:flutter/material.dart';
import 'package:social_media/homepage.dart';

void main() {
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.white,
          dividerColor: Colors.black12,
          brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}