import 'package:flutter/material.dart';
import 'package:lets_eat/models/message.dart';

class StingMessageScreen extends StatelessWidget {
  List<StingMessage> messageList = [];

  StingMessageScreen({required this.messageList, super.key});

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
              StingMessage message = messageList[index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('콕 찔러보기', style: TextStyle(fontSize: 12)),
                    Text('${message.friendName}님이 콕 찔렀습니다!'),
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
