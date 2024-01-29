import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lets_eat/model/user.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  final String USER_KEY = "USER_KEY";
  User userInfo = User(id: -1, username: "", token: "");

  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString(USER_KEY);

    return userData != null ? User.fromJson(jsonDecode(userData)) : null;
  }

  void setInfo(
      {required int id, required String username, required String token}) {
    userInfo.id = id;
    userInfo.username = username;
    userInfo.token = token;
  }

  void setName({required String username}) {
    userInfo.username = username;
  }

  String getName() {
    return userInfo.username;
  }
}
