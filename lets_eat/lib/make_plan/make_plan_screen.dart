import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MakePlanView extends StatefulWidget {
  @override
  _MakePlanViewState createState() => _MakePlanViewState();
}

class _MakePlanViewState extends State<MakePlanView> {
  DateTime expirationDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("만들기")),
      body: SafeArea (
        child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("날짜를 선택해주세요"),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: expirationDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != expirationDate)
                setState(() {
                  expirationDate = picked;
                });
            },
          ),
          ListTile(
            title: Text("시작: ${DateFormat('yy년 MM월 dd일').format(DateTime.now())}"),
          ),
          ListTile(
            title: Text("종료: ${DateFormat('yy년 MM월 dd일').format(expirationDate)}"),
          ),
          ListTile(
            title: Text("카메라 뷰"), // CameraView() 대체
            onTap: () {
              // 카메라 뷰 로직 구현
            },
          ),
          ListTile(
            title: Text("약속 만들기"),
            onTap: () {
              // QRCodeView 로직 구현 및 이동
            },
          ),
        ],
      ),
      )
    );
  }
}
