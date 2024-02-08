import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/api.dart';

import 'api_login.dart';

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
    if (response.statusCode >= 200 && response.statusCode < 300){
      debugPrint('signup: ${response.body}');
      debugPrint('회원가입 성공');
      Navigator.pop(context);
      loginAPI(email, password, context);
    } else {
      // 서버에서 에러나는 원인을 알려줘야 함
      // 이미 있는 유저입력 -> 이미 등록된 유저입니다.
      // 서버오류 -> 일시적인 오류로 가입을 할 수 없습니다. \n잠시 후 다시 이용해 주세요.
      Fluttertoast.showToast(msg: '회원가입 실패');
    }
  } catch (e) {
    debugPrint(e.toString());
    throw Exception('Failed to load data');
  }
}
