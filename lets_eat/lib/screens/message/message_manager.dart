import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lets_eat/models/API.dart';
import 'package:lets_eat/models/message.dart';
import 'package:lets_eat/screens/message/user_manager.dart';

class MessageManager {
  static final MessageManager _instance = MessageManager._internal();

  factory MessageManager() {
    return _instance;
  }

  MessageManager._internal();

  UserManager userManager = UserManager();
  List<Message> messageList = [];

  Future<void> fetchMessages() async {
    try {
      final response = await http.get(
          Uri.parse(baseUrl + ApiType.getMessages.rawValue),
          headers: headers);

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
      print('Error fetching messages: $error');
    }
  }

  String _formatDate(DateTime date) {
    // Format the date as needed
    // You can use the intl package for more advanced date formatting
    return date.toString();
  }
}
