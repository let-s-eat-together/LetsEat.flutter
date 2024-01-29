import 'package:flutter/material.dart';
import 'package:lets_eat/const/tabs.dart';
import 'package:lets_eat/screen/friend/friend_list_screen.dart';
import 'package:lets_eat/screen/make_plan/make_plan_screen.dart';
import 'package:lets_eat/screen/message/message_screen.dart';
import 'package:lets_eat/screen/plan/plan_screen.dart';
import 'package:lets_eat/screen/profile/profile_screen.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUI createState() => _HomeUI();
}

class _HomeUI extends State<HomeUI> {
  int _selectedIndex = 0;

  // BottomNavigation Items
  List _widgetOptions = [
    PlanScreen(), // Plan

    FriendListScreen(), // Friends

    MakePlanView(), // Make Plan

    MessageScreen(), // Message

    ProfileScreen(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            TABS[_selectedIndex].label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // BottomNavigationBar Widget
          type: BottomNavigationBarType.fixed,

          // BottomNavigation Colors
          backgroundColor: Color.fromARGB(255, 187, 157, 211),
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
          items: TABS.map((TabInfo tab) {
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
