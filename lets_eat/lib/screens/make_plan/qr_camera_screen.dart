import 'package:flutter/material.dart';
import 'package:lets_eat/models/api.dart';
import 'package:lets_eat/provider/user_provider.dart';
import 'dart:convert';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QRCameraScreen extends StatefulWidget {
  const QRCameraScreen({super.key});

  @override
  _QRCameraScreenState createState() => _QRCameraScreenState();
}

class _QRCameraScreenState extends State<QRCameraScreen> {
  void parseData(List<String> datas, String token) {
    if (datas.length == 2) {
      debugPrint('data: ${datas[0]}, ${datas[1]}');
      String expirationDate = datas[0];
      String friendId = datas[1];
      sendQRData(expirationDate, friendId, token);
    } else {
      debugPrint('QR코드를 다시 스캔해주세요.');
    }
  }

  Future<void> sendQRData(
      String? expirationDate, String? friendId, String token) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + ApiType.createPlan.rawValue),
        // headers: API.getHeaderWithToken(token),
        body: jsonEncode(
          <String, dynamic>{
            'expired_date': expirationDate,
            'userNumber': friendId,
          },
        ),
      );
      debugPrint('Success to request: ${response.body}');
      _showAlertAndHandleResponse(response.statusCode, response.body);
    } catch (e) {
      debugPrint('Failed to request: $e');
      _showAlertAndHandleResponse(500, '서버 오류');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final String rawString = barcodes[0].rawValue.toString();
          final List<String> datas = rawString.split('\n');
          parseData(datas, userProvider.user!.token);
        },
      ),
    );
  }

  void _showAlertAndHandleResponse(int statusCode, String body) async {
    String message;
    switch (statusCode) {
      case 200:
        message = '친구 요청을 성공적으로 보냈습니다.';
        break;
      case 400:
        message = '잘못된 요청입니다.';
        break;
      case 401:
        message = '토큰이 만료되었습니다. 다시 로그인해주세요.';
        break;
      case 500:
        message = '서버 오류입니다. 잠시 후 다시 시도해주세요.';
        break;
      default:
        message = '알 수 없는 오류가 발생했습니다.';
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알림'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );

    // API 응답에 따른 추가 작업 (필요한 경우)
  }
}
