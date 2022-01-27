import 'dart:ui';

import 'package:flutter/material.dart';
import '/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Application',
      theme: ThemeData(
        //primaryColor: Colors.amber[800],
        fontFamily: 'Georgia',
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          color: Colors.amber,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            fontSize: 36,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.amber),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 18,
          ),
          labelStyle: TextStyle(
            fontSize: 35,
            decorationColor: Colors.red,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.amberAccent,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.black),
          headline2: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'TimeNewRoma',
              color: Colors.black),
          headline3: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              height: 1.5,
              wordSpacing: 0.5),
          bodyText2: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),

      //Dark mode style
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        dividerColor: Colors.white,
        fontFamily: 'Georgia',
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          color: Colors.amber,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            fontSize: 36,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.amber),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 18,
          ),
          labelStyle: TextStyle(
            fontSize: 35,
            decorationColor: Colors.red,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.amberAccent,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'TimeNewRoma',
              color: Colors.black),
          headline3: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline4: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'TimeNewRoma',
              color: Colors.white),
          bodyText1: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              height: 1.5,
              wordSpacing: 0.5),
          bodyText2: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      home: const Home(),
    );
  }
}
