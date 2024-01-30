import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/model/API.dart';

class AddButton extends StatefulWidget {
  final String friendName;

  AddButton({required this.friendName});

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  Future<void> addFriend(String to) async {
    print('add $to');
    final Map<String, String> headers = {
      // 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;',
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl + ApiType.addFriend.rawValue),
        headers: headers,
      );
      print(response.body);
    } catch (e) {
      print('Failed to request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_circle),
      onPressed: () {
        // Add your logic for adding a friend here
        // You can open a dialog, navigate to another screen, etc.

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('친구 추가'),
                content: Text('${widget.friendName}을 친구 추가하시겠습니까?'),
                actions: [
                  TextButton(
                    child: Text('Yes'),
                    onPressed: () {
                      addFriend(widget.friendName);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}
