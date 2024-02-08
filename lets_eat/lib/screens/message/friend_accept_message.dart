import 'package:flutter/material.dart';
import 'package:lets_eat/models/message.dart';

class FriendAcceptMessageScreen extends StatelessWidget {
  List<FriendAcceptMessage> messageList = [];

  FriendAcceptMessageScreen({required this.messageList, super.key});

  @override
  Widget build(BuildContext context) {
    return messageList.isEmpty
        ? const Center(
            child: Text(
              '현재 알림이 없습니다.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        : ListView.separated(
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              FriendAcceptMessage message = messageList[index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('친구 요청 수락', style: TextStyle(fontSize: 12)),
                    Text('${message.friendName}님이 친구 요청을 수락했습니다.')
                  ],
                ),
                trailing: const Padding(
                  padding: EdgeInsets.all(10.0),
                  // child: Text(message
                  //     style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
  }
}
