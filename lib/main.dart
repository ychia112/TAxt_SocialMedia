import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './utils/routes.dart';
import 'providers/metamask_provider.dart';
import './homepage.dart';
import './pages/login.dart';
import 'package:ios_proj01/utils/user_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  HttpOverrides.global = MyHttpOverrides();
  await UserPreferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MetaMask()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyRoutes.loginRoute,
      theme: ThemeData(
         appBarTheme: const AppBarTheme(
           systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
           iconTheme: IconThemeData(color: Colors.black,),
         ),
       ),
      routes: {
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.homeRoute: (context) => const HomePage()
      },
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}