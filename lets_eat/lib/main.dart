import 'package:flutter/material.dart';
import 'package:lets_eat/screen/login.dart';
import 'package:lets_eat/screen/signup.dart';
import 'package:lets_eat/screen/test_planlist_screen.dart';

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
        '/planlist' : (context) => Test_Planlist_Screen(), // Planlist_Screen으로 교체
      },
    );
  }
}
