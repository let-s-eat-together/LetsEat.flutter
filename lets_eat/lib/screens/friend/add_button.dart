import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/api.dart';
import 'package:lets_eat/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AddButton extends StatefulWidget {
  final String friendName;

  const AddButton({super.key, required this.friendName});

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  Future<void> addFriend(String to, String token) async {
    debugPrint('add $to');

    try {
      final response = await http.post(
        Uri.parse(baseUrl + ApiType.requestFriend.rawValue),
        headers: API.getHeaderWithToken(token),
      );
      debugPrint(response.body);
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final token = userProvider.user?.token;

    return IconButton(
      icon: const Icon(Icons.add_circle),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('친구 추가'),
              content: Text('${widget.friendName}을 친구 추가하시겠습니까?'),
              actions: [
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    addFriend(widget.friendName, token!);
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
