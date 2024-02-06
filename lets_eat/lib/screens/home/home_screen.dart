import 'package:flutter/material.dart';
import 'package:lets_eat/models/tabs.dart';
import 'package:lets_eat/screens/friend/friend_list_screen.dart';
import 'package:lets_eat/screens/make_plan/make_plan_screen.dart';
import 'package:lets_eat/screens/message/message_screen.dart';
import 'package:lets_eat/screens/plan/plan_screen.dart';
import 'package:lets_eat/screens/setting/setting_screen.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  _HomeUI createState() => _HomeUI();
}

class _HomeUI extends State<HomeUI> {
  int _selectedIndex = 0;

  // BottomNavigation Items
  final List _widgetOptions = [
    const PlanScreen(), // Plan

    const FriendListScreen(), // Friends

    const MakePlanView(), // Make Plan

    const MessageScreen(), // Message

    const ProfileScreen(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // BottomNavigationBar Widget
          type: BottomNavigationBarType.fixed,

          // BottomNavigation Colors
          backgroundColor: const Color.fromARGB(255, 187, 157, 211),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),

          // Selected Index
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },

          // BottomNavigation Items
          items: tabs.map((TabInfo tab) {
            return BottomNavigationBarItem(
              icon: Icon(tab.icon),
              label: tab.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}
