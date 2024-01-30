class Plan {
  final int planId;
  final String creationDate;
  final String expirationDate;
  final String friendName;

  Plan(
      {required this.planId,
      required this.creationDate,
      required this.expirationDate,
      required this.friendName});

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      planId: json['planId'],
      creationDate: json['creationDate'],
      expirationDate: json['expirationDate'],
      friendName: json['friendName'],
    );
  }
}
