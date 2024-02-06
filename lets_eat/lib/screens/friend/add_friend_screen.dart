import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/api.dart';
import 'package:lets_eat/provider/user_provider.dart';
import 'package:lets_eat/screens/friend/add_button.dart';
import 'package:provider/provider.dart';

import '../../models/friend.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({Key? key}) : super(key: key);

  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Friend> searchList = [];

  Future<void> searchFriends(String inputText, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiType.search.rawValue}/$inputText'),
        headers: API.getHeaderWithToken(token),
      );

      List<dynamic> data = jsonDecode(response.body);
      List<Friend> searchResults = data.map((e) => Friend.fromJson(e)).toList();

      setState(() {
        searchList = searchResults;
      });
      debugPrint('Success to request: ${response.body}');
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final token = userProvider.user?.token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('친구 추가하기'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '친구의 email을 검색하여 추가하세요.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'friend@email.com',
                        // prefixIcon: Icon(Icons.search),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an email' : null,
                      // onFieldSubmitted: (value) {
                      //   searchFriends(value);
                      // },
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      searchFriends(_textEditingController.text, token!);
                      // Trigger the friend search when the button is pressed
                      // searchFriends(_textEditingController.text);
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: searchList.map((friend) {
                return ListTile(
                  title: Text(friend.name),
                  subtitle: Text(friend.email),
                  trailing: AddButton(friendName: friend.name),
                );
              }).toList(),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Tap on a friend to add them.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
