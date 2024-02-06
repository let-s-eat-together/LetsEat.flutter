import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lets_eat/models/api.dart';
import 'package:lets_eat/models/friend.dart';
import 'package:lets_eat/provider/user_provider.dart';
import 'package:lets_eat/screens/friend/add_friend_screen.dart';
import 'package:provider/provider.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  String searchText = '';
  List<Friend> friendList = [];

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    getFriendList(token!);
  }

  Future<void> getFriendList(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + ApiType.getFriend.rawValue),
        headers: API.getHeaderWithToken(token),
      );

      List<dynamic> data = jsonDecode(response.body);
      List<Friend> friendList = data.map((e) => Friend.fromJson(e)).toList();

      setState(() {
        this.friendList = friendList;
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 187, 157, 211),
        title: const Text(
          '친구',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AddFriendScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => getFriendList(token!),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              SearchBar(
                hintText: '친구 검색',
                leading: const Icon(Icons.search),
                controller: _textEditingController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                trailing: [
                  IconButton(
                    onPressed: () {
                      _textEditingController.clear();
                      setState(() {
                        searchText = '';
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
                elevation: MaterialStateProperty.all(10.0),
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  minHeight: 50,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: friendList.length,
                  itemBuilder: (context, index) {
                    Friend friend = friendList[index];
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(friend.name),
                    );
                  },
                  // itemCount: friendList
                  //     .where((friend) =>
                  //         friend.startsWith(searchText) || searchText == '')
                  //     .length,
                  // itemBuilder: (context, index) {
                  //   String name = friendList
                  //       .where((name) =>
                  //           name.startsWith(searchText) || searchText == '')
                  //       .elementAt(index);
                  //   return ListTile(
                  //     leading: const CircleAvatar(
                  //       child: Icon(Icons.person),
                  //     ),
                  //     title: Text(name),
                  //   );
                  // },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
