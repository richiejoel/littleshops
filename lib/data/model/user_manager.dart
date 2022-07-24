class UserManager {
  static final UserManager _userManager = UserManager._internal();

  String? email;

  factory UserManager() {
    return _userManager;
  }

  UserManager._internal();
}