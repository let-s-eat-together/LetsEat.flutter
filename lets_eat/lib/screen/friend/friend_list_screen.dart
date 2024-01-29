import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:lets_eat/model/friend.dart';
import 'package:lets_eat/screen/friend/add_button.dart';

class FriendListScreen extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  String searchText = '';
  final List<String> friendList = [
    "김서근",
    "포뇨",
    "하울",
    "소피아",
    "캐시퍼",
    "소스케",
    "치히로",
    "하쿠",
    "가오나시",
    "제니바",
    "카브",
    "마르클",
    "토토로",
    "사츠키",
    "지브리",
    "스튜디오",
    "캐릭터"
  ];

  List<Friend> parseFriends(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Friend>((json) => Friend.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SearchTextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: friendList
                    .where((name) =>
                        name.startsWith(searchText) || searchText == "")
                    .length,
                itemBuilder: (context, index) {
                  String name = friendList
                      .where((name) =>
                          name.startsWith(searchText) || searchText == "")
                      .elementAt(index);
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(name),
                    trailing: AddButton(
                      friendName: name,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final Function(String) onChanged;

  SearchTextField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.clear),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
