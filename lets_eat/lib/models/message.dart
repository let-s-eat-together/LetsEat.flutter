// Message.dart
class Message {
  int planId;
  String creationDate;
  String friendrName;
  int count;

  Message(
      {required this.planId,
      required this.creationDate,
      required this.friendrName,
      required this.count});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      planId: json['planId'],
      creationDate: json['creationDate'],
      friendrName: json['friendrName'],
      count: json['count'],
    );
  }
}
