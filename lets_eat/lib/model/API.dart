// uri
const String baseUrl = 'http://localhost:8080/';

// api type
enum ApiType {
  signUp, // signup
  login, // login
  plan, // create plan
  getPlan, // get plan
  complete, // plan complete
  addFriend, // friend request
  acceptFriend, // friend accept
  getFriend, // get friend list
  deleteFriend, // delete friend
  search, // search friend
  sting, // sting
  profile, // modify profile
}

// api raw value
extension APIModelExtension on ApiType {
  String get rawValue {
    switch (this) {
      case ApiType.signUp:
        return 'signup';
      case ApiType.login:
        return 'login';
      case ApiType.plan:
        return 'plan';
      case ApiType.getPlan:
        return 'plan';
      case ApiType.complete:
        return 'complete';
      case ApiType.addFriend:
        return 'requestFriend';
      case ApiType.acceptFriend:
        return 'acceptFriend';
      case ApiType.getFriend:
        return 'friend';
      case ApiType.deleteFriend:
        return 'friend';
      case ApiType.search:
        return 'search';
      case ApiType.sting:
        return 'sting';
      case ApiType.profile:
        return 'profile';
    }
  }
}
