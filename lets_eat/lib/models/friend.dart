class Friend {
  int id;
  String email;
  String name;

  Friend({
    required this.id,
    required this.email,
    required this.name,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      email: json['email'],
      name: json['username'],
    );
  }
}
