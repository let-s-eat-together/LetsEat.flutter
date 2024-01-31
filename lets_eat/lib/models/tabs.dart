import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  const TabInfo({required this.icon, required this.label});
}

const tabs = [
  TabInfo(icon: Icons.list, label: '약속'),
  TabInfo(icon: Icons.people, label: '친구'),
  TabInfo(icon: Icons.add, label: '만들기'),
  TabInfo(icon: Icons.message, label: '알림'),
  TabInfo(icon: Icons.settings, label: '설정'),
];
