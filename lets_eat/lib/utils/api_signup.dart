import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/api.dart';

Future<void> signupAPI(String? email, String? password, String? nickname,
    BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl + ApiType.signup.rawValue),
      headers: API.getHeader(),
      body: jsonEncode(<String, String>{
        'email': email!,
        'password': password!,
        'username': nickname!,
      }),
    );
    debugPrint('signup: ${response.body}');
    debugPrint('회원가입 성공');
    Navigator.pop(context);
  } catch (e) {
    print('회원가입 실패');
    // 값이 틀려서 실패 or 다른 요인으로 실패 구분하기
    print('~가 틀렸습니다');
    print('잠시후 다시 시도해 주세요');
    debugPrint(e.toString());
    throw Exception('Failed to load data');
  }
}
