import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  const TabInfo({required this.icon, required this.label});
}

const TABS = [
  TabInfo(icon: Icons.list, label: 'Plan'),
  TabInfo(icon: Icons.people, label: 'Friends'),
  TabInfo(icon: Icons.add, label: 'Add'),
  TabInfo(icon: Icons.alarm, label: 'Likes'),
  TabInfo(icon: Icons.account_circle, label: 'Profile'),
];
