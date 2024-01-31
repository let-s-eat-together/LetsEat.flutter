import 'package:flutter/material.dart';

import 'package:lets_eat/screens/home/home_screen.dart';
import 'package:lets_eat/screens/login/login.dart';
import 'package:lets_eat/screens/login/signup.dart';

import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  // 바인딩 초기화: main() 함수에서 async를 쓰려면 필요
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
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
        '/signup': (context) => Signup(),
        '/home': (context) => HomeUI(),
      },
    );
  }
}
