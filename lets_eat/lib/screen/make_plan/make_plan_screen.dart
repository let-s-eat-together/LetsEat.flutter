import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_eat/screen/make_plan/qr_camera_screen.dart';
import 'package:lets_eat/screen/make_plan/qr_code_screen.dart';

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
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("날짜를 선택해주세요"),
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return SizedBox(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 3,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now().add(const Duration(minutes: 1)),
                          minimumDate: DateTime.now(),
                          maximumDate: DateTime(2101),
                          onDateTimeChanged: (DateTime newDate) {
                            if (newDate != null && newDate != expirationDate)
                              setState(() {
                                expirationDate = newDate;
                              });
                          },
                        ),
                      );
                    },
                  );
                },
                // onTap: () async {
                //   final DateTime? picked = await showDatePicker(
                //     context: context,
                //     initialDate: expirationDate,
                //     firstDate: DateTime.now(),
                //     lastDate: DateTime(2101),
                //   );
                //   if (picked != null && picked != expirationDate)
                //     setState(() {
                //       expirationDate = picked;
                //     });
                // },
              ),
              ListTile(
                title: Text(
                    "시작: ${DateFormat('yy년 MM월 dd일').format(DateTime.now())}"),
              ),
              ListTile(
                title: Text(
                    "종료: ${DateFormat('yy년 MM월 dd일').format(expirationDate)}"),
              ),
              ListTile(
                title: Text("QR 카메라"), // CameraView() 대체
                onTap: () {
                  Navigator.of(context).push(
                  
                    MaterialPageRoute(builder: (context) => QRCameraScreen()),
                  );
                  // 카메라 뷰 로직 구현
                },
              ),
              ListTile(
                title: Text("QR 코드"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => QRCodeScreen(expirationDate: expirationDate,)),
                  );
                  // QRCodeView 로직 구현 및 이동
                },
              ),
            ],
          ),
        ));
  }
}
