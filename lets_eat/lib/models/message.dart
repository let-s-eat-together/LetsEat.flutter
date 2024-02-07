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

class StingMessage {
  int planId;
  String creationDate;
  String friendName;
  int count;

  StingMessage({
    required this.planId,
    required this.creationDate,
    required this.friendName,
    required this.count,
  });

  factory StingMessage.fromJson(Map<String, dynamic> json) {
    return StingMessage(
      planId: json['plan_id'],
      creationDate: json['creation_date'],
      friendName: json['other_user_name'],
      count: json['countSting'],
    );
  }
}

class FriendAcceptMessage {
  String friendName;
  // String creationDate;

  FriendAcceptMessage({
    required this.friendName,
    // required this.creationDate,
  });

  factory FriendAcceptMessage.fromJson(Map<String, dynamic> json) {
    return FriendAcceptMessage(
      friendName: json['friendName'],
      // creationDate: json['creationTime'],
    );
  }
}

class FriendRequestMessage {
  int friendId;
  String friendName;
  String creationDate;

  FriendRequestMessage({
    required this.friendId,
    required this.friendName,
    required this.creationDate,
  });

  factory FriendRequestMessage.fromJson(Map<String, dynamic> json) {
    return FriendRequestMessage(
      friendId: json['requestingUserId'],
      friendName: json['friendName'],
      creationDate: json['creationTime'],
    );
  }
}
