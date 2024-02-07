import 'package:flutter/material.dart';
import 'package:lets_eat/models/message.dart';

class FriendRequestMessageScreen extends StatelessWidget {
  List<FriendRequestMessage> messageList = [];

  FriendRequestMessageScreen({required this.messageList, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: messageList.length,
      itemBuilder: (context, index) {
        FriendRequestMessage message = messageList[index];
        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('친구 요청', style: TextStyle(fontSize: 12)),
              Text('${message.friendName}님이 친구 요청을 보냈습니다.'),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(message.creationDate,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
