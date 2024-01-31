import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_eat/screens/make_plan/qr_camera_screen.dart';
import 'package:lets_eat/screens/make_plan/qr_code_screen.dart';

class MakePlanView extends StatefulWidget {
  @override
  _MakePlanViewState createState() => _MakePlanViewState();
}

class _MakePlanViewState extends State<MakePlanView> {
  DateTime expirationDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
              onDateChanged: (DateTime newDate) {
                if (newDate != expirationDate) {
                  setState(() {
                    expirationDate = newDate;
                  });
                }
              },
            ),
            ListTile(
              title: Text(
                  '시작: ${DateFormat('yy년 MM월 dd일').format(DateTime.now())}'),
            ),
            ListTile(
              title: Text(
                  '종료: ${DateFormat('yy년 MM월 dd일').format(expirationDate)}'),
            ),
            ListTile(
              title: const Text('QR코드 스캔하기'), // CameraView() 대체
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => QRCameraScreen()),
                );
                // 카메라 뷰 로직 구현
              },
            ),
            ListTile(
              title: const Text('QR코드 만들기'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QRCodeScreen(
                      expirationDate: expirationDate,
                    ),
                  ),
                );
                // QRCodeView 로직 구현 및 이동
              },
            ),
          ],
        ),
      ),
    );
  }
}
