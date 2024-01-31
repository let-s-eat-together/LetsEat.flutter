// Friend.dart
class Friend {
  int id;
  String name;

  Friend({
    required this.id,
    required this.name,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['friend_id'],
      name: json['friend_name'],
    );
  }
}
