import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:lets_eat/model/API.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class QRCameraScreen extends StatefulWidget {
  @override
  _QRCameraScreenState createState() => _QRCameraScreenState();
}

class _QRCameraScreenState extends State<QRCameraScreen> {
  void parseData(List<String> datas) {
    if (datas.length == 2) {
      debugPrint('data: ${datas[0]}, ${datas[1]}');
      String expirationDate = datas[0];
      String friendId = datas[1];
      sendQRData(expirationDate, friendId);
    } else {
      print('QR코드를 다시 스캔해주세요.');
    }
  }

  Future<void> sendQRData(String? expirationDate, String? friendId) async {
    final Map<String, String> headers = {
      // 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;',
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl + ApiType.addFriend.rawValue),
        headers: headers,
        body: jsonEncode(
          <String, dynamic>{
            'expirationDate': expirationDate,
            'friendId': friendId,
            'Id': 1,
          },
        ),
      );
      // debugPrint(response.body);
      debugPrint('Success: $response');
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          // final Uint8List? image = capture.image;
          final String rawString = barcodes[0].rawValue.toString();
          final List<String> datas = rawString.split('\n');
          // final List<dynamic> datas = barcodes.rawsplit(' ');
          // final List<String> datas = capture.raw.split('+');
          // for (final barcode in barcodes) {
          //   debugPrint('${barcodes.length}: ${barcode.rawValue}');
          // }
          parseData(datas);
        },
      ),
    );
  }
}
