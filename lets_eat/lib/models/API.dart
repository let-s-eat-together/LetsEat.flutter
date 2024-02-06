const String baseUrl = 'http://34.64.105.81:8080/';

final Map<String, String> headers = {
  // 'Authorization': 'Bearer $token',
  'Content-Type': 'application/json',
};

// api type
enum ApiType {
  signup, // signup
  login, // login
  createPlan, // create plan
  getPlan, // get plan
  complete, // plan complete
  requestFriend, // friend request
  acceptFriend, // friend accept
  getFriend, // get friend list
  deleteFriend, // delete friend
  search, // search friend
  sting, // sting
  profile, // modify profile
  getMessages, // get messages
}

// api raw value
extension APIModelExtension on ApiType {
  String get rawValue {
    switch (this) {
      case ApiType.signup:
        return 'sign-up';
      case ApiType.login:
        return 'login';
      case ApiType.createPlan:
        return 'plan/create';
      case ApiType.getPlan:
        return 'plan';
      case ApiType.complete:
        return 'plan/complete';
      case ApiType.requestFriend:
        return 'friend/request';
      case ApiType.acceptFriend:
        return 'friend/accept';
      case ApiType.getFriend:
        return 'friend';
      case ApiType.deleteFriend:
        return 'friend/delete';
      case ApiType.getMessages:
        return 'message';
      case ApiType.search:
        return 'search';
      case ApiType.sting:
        return 'sting';
      case ApiType.profile:
        return 'profile';
    }
  }
}
