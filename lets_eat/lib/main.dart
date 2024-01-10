import 'package:flutter/material.dart';
import 'plan/plan_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Let`s Eat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainUI(),
    );
  }
}

class MainUI extends StatefulWidget {
  @override
  _MainUI createState() => _MainUI();
}

class _MainUI extends State<MainUI> {
  int _selectedIndex = 0;

  // BottomNavigation Items
  List _widgetOptions = [
    // Plan 
    PlanScreen(),

    // Friends
    Text(
      'Friends',
      style: TextStyle(fontSize: 30),),
    // Add
    Text('Add',
      style: TextStyle(fontSize: 30),),
    
    // Alarm
    Text('Alarm',
      style: TextStyle(fontSize: 30),),

    // Profile
    Text('Profile',
      style: TextStyle(fontSize: 30),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
