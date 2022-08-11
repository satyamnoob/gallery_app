import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
            // color: Colors.amberAccent,
            fontFamily: 'Rubik',
            fontSize: 25,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
        // fontFamily: 'Rubik',
      ),
      home: const HomeScreen(),
    );
  }
}

