class Message {
  String messageType;
  String creationTime;
  String friendName;

  Message({
    required this.messageType, // Add initializer for 'messageType' field
    required this.creationTime,
    required this.friendName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageType: json['messageType'],
      creationTime: json['creationTime'],
      friendName: json['friendName'],
    );
  }
}
