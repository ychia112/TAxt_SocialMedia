import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './utils/routes.dart';
import './providers/session_provider.dart';
import './homepage.dart';
import './pages/login.dart';

void main(){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Session()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyRoutes.loginRoute,
      routes: {
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.homeRoute: (context) => const HomePage()
      },
    );
  }
}