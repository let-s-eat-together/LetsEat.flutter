import 'package:flutter/material.dart';
import 'package:lets_eat/screen/login.dart';
import 'package:lets_eat/screen/signup.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/signup' : (context) => Signup(),
        '/planlist' : (context) => Login(),
      },
    ),
  );
}
