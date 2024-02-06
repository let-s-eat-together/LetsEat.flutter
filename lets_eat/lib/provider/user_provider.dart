import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lets_eat/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString(_userKey);

    if (userData != null) {
      final decodedUser = json.decode(userData) as Map<String, dynamic>;
      _user = User.fromJson(decodedUser);
      notifyListeners();
    }

    return _user ?? User(id: 0, username: '', token: '');
  }

  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, jsonEncode(user.toJson()));
    _user = user;
    notifyListeners();
  }

  static const String _userKey = 'user';
}
