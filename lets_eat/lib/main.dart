import 'package:flutter/material.dart';
import 'package:lets_eat/provider/user_provider.dart';

import 'package:lets_eat/screens/home/home_screen.dart';
import 'package:lets_eat/screens/login/login.dart';
import 'package:lets_eat/screens/login/signup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
String startPage = '/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  // String username = prefs.getString('username') ?? '';
  // if (username != '') {
  //   startPage = '/home';
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        initialRoute: '/',
        title: 'Let`s Eat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const Login(),
          '/signup': (context) => const Signup(),
          '/home': (context) => const HomeUI(),
        },
      ),
    );
  }
}
