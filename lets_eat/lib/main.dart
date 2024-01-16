import 'package:flutter/material.dart';
import 'package:lets_eat/screen/login.dart';
import 'package:lets_eat/screen/signup.dart';
import 'package:lets_eat/screen/test_planlist_screen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/signup' : (context) => Signup(),
        '/planlist' : (context) => Test_Planlist_Screen(), // Planlist_Screen으로 교체
      },
    ),
  );
}
