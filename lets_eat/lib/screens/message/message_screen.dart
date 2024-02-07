import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lets_eat/models/message.dart';
import 'package:lets_eat/models/api.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/provider/user_provider.dart';
import 'package:lets_eat/screens/message/friend_accept_message.dart';
import 'package:lets_eat/screens/message/friend_request_message.dart';
import 'package:lets_eat/screens/message/sting_message.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<StingMessage> messageListSting = [];
  List<FriendRequestMessage> messageListFriendRequest = [];
  List<FriendAcceptMessage> messageListFriendAccept = [];

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    getMessagesSting(token!);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final token = userProvider.user?.token;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 187, 157, 211),
          title: const Text(
            '알림',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => getMessagesSting(token!),
          child: Column(
            children: [
              TabBar(
                onTap: (value) {
                  debugPrint('tab: $value');
                  getMessageForTab(value, token!);
                },
                tabs: const [
                  Tab(text: '콕 찔러보기'),
                  Tab(text: '친구 요청'),
                  Tab(text: '친구 요청 수락'),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  StingMessageScreen(messageList: messageListSting),
                  FriendRequestMessageScreen(
                      messageList: messageListFriendRequest),
                  FriendAcceptMessageScreen(
                      messageList: messageListFriendAccept),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getMessageForTab(int tabIndex, String token) {
    switch (tabIndex) {
      case 0:
        getMessagesSting(token);
        break;
      case 1:
        getMessagesFriendRequest(token);
        break;
      case 2:
        getMessagesFriendAccept(token);
        break;
    }
  }

  Future<void> getMessagesSting(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiType.messageSting.rawValue}'),
        headers: API.getHeaderWithToken(token),
      );
      List<dynamic> data = jsonDecode(response.body);
      List<StingMessage> messageSting =
          data.map((e) => StingMessage.fromJson(e)).toList();
      setState(() {
        messageListSting = messageSting;
      });
      debugPrint('Success to request Sting: ${response.body}');
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }

  Future<void> getMessagesFriendRequest(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiType.messageFriendRequest.rawValue}'),
        headers: API.getHeaderWithToken(token),
      );
      List<dynamic> data = jsonDecode(response.body);
      List<FriendRequestMessage> messageFreq =
          data.map((e) => FriendRequestMessage.fromJson(e)).toList();
      setState(() {
        messageListFriendRequest = messageFreq;
      });
      debugPrint('Success to request FriendRequest: ${response.body}');
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }

  Future<void> getMessagesFriendAccept(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiType.messageFriendAccept.rawValue}'),
        headers: API.getHeaderWithToken(token),
      );
      List<dynamic> data = jsonDecode(response.body);
      List<FriendAcceptMessage> messageFacc =
          data.map((e) => FriendAcceptMessage.fromJson(e)).toList();
      setState(() {
        messageListFriendAccept = messageFacc;
      });
      debugPrint('Success to request FriendAccpt: ${response.body}');
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }
}
