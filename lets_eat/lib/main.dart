import 'package:flutter/material.dart';
import 'package:lets_eat/screen/home/home_screen.dart';

import 'package:lets_eat/screen/login/login.dart';
import 'package:lets_eat/screen/login/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Let`s Eat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => Login(),
        '/signup' : (context) => Signup(),
        '/home' : (context) => HomeUI(),
      },
    );
  }
}

