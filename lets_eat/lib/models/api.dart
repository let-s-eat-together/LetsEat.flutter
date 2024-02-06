class API {
  static Map<String, String> getHeader() {
    final Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    return header;
  }

  static Map<String, String> getHeaderWithToken(String token) {
    final Map<String, String> headerWithToken = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return headerWithToken;
  }
}

const String baseUrl = 'http://34.64.105.81:8080/';

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
  messageSting, // message sting
  messageFriendAccept, // message accept
  messageFriendRequest, // message request
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
      case ApiType.messageSting:
        return 'message/sting';
      case ApiType.messageFriendAccept:
        return 'message/friend/accept';
      case ApiType.messageFriendRequest:
        return 'message/friend/request';
    }
  }
}
