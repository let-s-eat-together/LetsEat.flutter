import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lets_eat/models/message.dart';
import 'package:lets_eat/models/api.dart';
import 'package:http/http.dart' as http;
import 'package:lets_eat/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Dummy data
  List<Message> messageList = [
    Message(messageType: '콕 찔러보기', creationTime: '2023-01-01', friendName: '1'),
    Message(messageType: '콕 찔러보기', creationTime: '2023-01-01', friendName: '2'),
    Message(messageType: '친구 요청', creationTime: '2023-01-01', friendName: '3'),
    Message(messageType: '친구 요청', creationTime: '2023-01-01', friendName: '4'),
    Message(
        messageType: '친구 요청 수락', creationTime: '2023-01-01', friendName: '5'),
    Message(
        messageType: '친구 요청 수락', creationTime: '2023-01-01', friendName: '6'),
  ];

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    getMessages(token!);
  }

  Future<void> getMessages(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiType.messageSting.rawValue}'),
        headers: API.getHeaderWithToken(token),
      );
      List<Message> messages = jsonDecode(response.body);
      setState(() {
        messageList = messages;
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
          '알림',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => getMessages(token!),
        child: ListView.separated(
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            Message message = messageList[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.messageType,
                      style: const TextStyle(fontSize: 12)),
                  message.messageType == '친구 요청'
                      ? Text('${message.friendName}님이 친구 요청을 보냈습니다.')
                      : message.messageType == '친구 요청 수락'
                          ? Text('${message.friendName}님이 친구 요청을 수락했습니다.')
                          : Text('${message.friendName}님이 콕 찔렀습니다!'),
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(message.creationTime,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
