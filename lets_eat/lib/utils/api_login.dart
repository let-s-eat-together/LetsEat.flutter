import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/api.dart';
import 'package:lets_eat/models/user.dart';
import 'package:lets_eat/provider/user_provider.dart';
import 'package:provider/provider.dart';

Future<void> loginAPI(
    String? email, String? password, BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    final response = await http.post(
      Uri.parse(baseUrl + ApiType.login.rawValue),
      headers: API.getHeader(),
      body: jsonEncode(<String, String>{
        'email': email!,
        'password': password!,
      }),
    );
    if (response.statusCode >= 200 && response.statusCode < 300){
      var data = jsonDecode(response.body);
      debugPrint('login: ${response.body}');
      await userProvider.saveUser(
        User(
          id: data['user_id'],
          username: data['name'],
          token: data['token'],
        ),
      );
      debugPrint(
        'data: ${userProvider.user!.username} | ${userProvider.user!.token} | ${userProvider.user!.id}');

      Navigator.of(context).pushNamed(
        '/home',
      );
    } else {
      // 서버에서 에러나는 원인을 알려줘야 함
      // 잘못입력 -> 등록되지 않은 유저이거나 비밀번호를 잘못 입력했습니다.
      // 서버오류 -> 일시적인 오류로 로그인을 할 수 없습니다. \n잠시 후 다시 이용해 주세요.
      Fluttertoast.showToast(msg: '로그인 실패');
    }
  } catch (e) {
    print('로그인 실패');
    throw Exception('Failed to load data: $e');
  }
}
