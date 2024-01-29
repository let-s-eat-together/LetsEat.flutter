import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Dummy data
  List<MessageItem> messageList = [
    MessageItem('콕 찔러보기', '떡볶이', '2', DateTime.now().subtract(Duration(days: 2))),
    MessageItem('콕 찔러보기', '간장치킨', '1', DateTime.now().subtract(Duration(hours: 5))),
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Set the height to 0 to hide the AppBar
        child: AppBar(
          title: Text('알림'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchMessages,
        child: ListView.builder(
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            MessageItem item = messageList[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('콕 찔러보기', style: TextStyle(fontSize: 12)),
                  Text('${item.otherUserName}님이 ${item.countString}번 콕 찔렀습니다!'),
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_timeElapsedString(item.creationDate),
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _fetchMessages() async {
    // Dummy implementation for fetching messages
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Update the messageList with new data
      messageList = [
        MessageItem('콕 찔러보기', 'New User', '3', DateTime.now()),
        ...messageList,
      ];
    });
  }

  String _timeElapsedString(DateTime date) {
    Duration difference = DateTime.now().difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now';
    }
  }
}

class MessageItem {
  final String title;
  final String otherUserName;
  final String countString;
  final DateTime creationDate;

  MessageItem(this.title, this.otherUserName, this.countString, this.creationDate);
}
