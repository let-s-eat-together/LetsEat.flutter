// User.dart
class User {
  final int id;
  final String username;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'],
      username: json['name'],
      token: json['token'],
    );
  }
}
