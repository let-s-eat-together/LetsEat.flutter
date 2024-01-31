import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/API.dart';

class StingButton extends StatefulWidget {
  final String otherUserName;
  final int planId;

  StingButton({required this.otherUserName, required this.planId});

  @override
  _StingButtonState createState() => _StingButtonState();
}

class _StingButtonState extends State<StingButton> {
  Future<void> sting() async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + ApiType.sting.rawValue),
        headers: headers,
      );
      debugPrint(response.body);
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }

  void sendMessage(String to) {
    // 메시지 전송 로직 구현
    debugPrint('send $to kok!');
  }

  void pressReject(String to) {
    // 거절 로직 구현
    debugPrint('reject $to kok!');
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 25,
      icon: const Icon(Icons.touch_app),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              title: const Text('콕 찔러보기', style: TextStyle(fontSize: 20)),
              content: Text('${widget.otherUserName}님을 콕 찌르시겠습니까?'),
              actions: [
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    sting();
                    sendMessage(widget.otherUserName);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}