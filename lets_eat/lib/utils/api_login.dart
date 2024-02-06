import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/API.dart';
import 'package:lets_eat/models/user.dart';

Future<void> loginAPI(
    String? email, String? password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl + ApiType.login.rawValue),
      headers: headers,
      body: jsonEncode(<String, String>{
        'id': email!,
        'password': password!,
      }),
    );
    var data = jsonDecode(response.body);
    debugPrint('login: ${response.body}');
    UserDataManager.saveUser(
      User(
        id: data['userNumber'],
        username: data['username'],
        token: data['token'],
      ),
    );
    debugPrint(response.body);
    Navigator.of(context).pushNamed(
      '/home',
      arguments: {
        'token': data['token'],
        'userNumber': data['userNumber'],
        'username': data['username'],
      },
    );
  } catch (e) {
    print('로그인 실패');
    print('잠시후 다시 시도해 주세요');
    throw Exception('Failed to load data: $e');
  }
}
