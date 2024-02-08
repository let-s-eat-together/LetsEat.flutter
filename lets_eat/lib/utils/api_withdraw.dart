import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/api.dart';

Future<void> withdrawAPI(String? token, BuildContext context) async {
  try {
    final response = await http.put(
      Uri.parse(baseUrl + ApiType.withdraw.rawValue),
      headers: API.getHeaderWithToken(token!),
    );
    debugPrint('withdraw: ${response.body}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Fluttertoast.showToast(msg: '회원탈퇴 성공');
    } else {
      // 서버에서 에러나는 원인을 알려줘야 함
      // 서버오류 -> 일시적인 오류로 탈퇴 할 수 없습니다. \n잠시 후 다시 이용해 주세요.
      Fluttertoast.showToast(msg: '회원탈퇴 실패');
    }
  } catch (e) {
    debugPrint(e.toString());
    throw Exception('Failed to load data');
  }
}
