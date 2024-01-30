import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lets_eat/model/message.dart';
import 'package:lets_eat/screen/message/user_manager.dart';

class MessageManager {
  static final MessageManager _instance = MessageManager._internal();

  factory MessageManager() {
    return _instance;
  }

  MessageManager._internal();

  UserManager userManager = UserManager();
  List<Message> messageList = [];

  Future<void> fetchMessages() async {
    final url = Uri.parse("http://34.22.94.135:8080/sting");
    // final accessToken = userManager.userInfo.token;

    final headers = {
      // "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.get(url, headers: headers);

      final List<dynamic> jsonMessages = jsonDecode(response.body);

      List<Message> messages = jsonMessages.map((json) {
        return Message.fromJson(json);
      }).toList();

      // Format the date
      messages.forEach((message) {
        message.creationDate =
            _formatDate(DateTime.parse(message.creationDate));
      });

      messageList = messages;
    } catch (error) {
      print("Error fetching messages: $error");
    }
  }

  String _formatDate(DateTime date) {
    // Format the date as needed
    // You can use the intl package for more advanced date formatting
    return date.toString();
  }
}
