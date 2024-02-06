// User.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String username;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'],
      username: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': username,
      'token': token,
    };
  }
}

class UserDataManager {
  static const String _userKey = 'user';

  static Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString(_userKey);

    if (userData != null) {
      final decodedUser = json.decode(userData) as Map<String, dynamic>;
      return User.fromJson(decodedUser);
    }
    return null;
  }
}
