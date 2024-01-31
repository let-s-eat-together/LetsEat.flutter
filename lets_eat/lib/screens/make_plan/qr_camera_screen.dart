import 'package:flutter/material.dart';
import 'package:lets_eat/models/API.dart';
import 'dart:convert';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class QRCameraScreen extends StatefulWidget {
  const QRCameraScreen({super.key});

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
      debugPrint('QR코드를 다시 스캔해주세요.');
    }
  }

  Future<void> sendQRData(String? expirationDate, String? friendId) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + ApiType.requestFriend.rawValue),
        headers: headers,
        body: jsonEncode(
          <String, dynamic>{
            'expirationDate': expirationDate,
            'friendId': friendId,
            'Id': 1,
          },
        ),
      );
      debugPrint(response.body);
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
          final String rawString = barcodes[0].rawValue.toString();
          final List<String> datas = rawString.split('\n');
          // for (final barcode in barcodes) {
          //   debugPrint('${barcodes.length}: ${barcode.rawValue}');
          // }
          parseData(datas);
        },
      ),
    );
  }
}
