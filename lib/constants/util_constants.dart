class UTIL_CONST {

  /// Navigation Drawer
  static const String HOME = "HOME";
  static const String PROFILE = "PROFILE";
  static const String FAVOURITE = "FAVOURITE";
  static const String MY_ORDERS = "MY_ORDERS";
  static const String ADD_PRODUCTS = "ADD_PRODUCTS";

  /// ROLE
  static const String CHIEF = "CHIEF";
  static const String CUSTOMER = "CUSTOMER";
  static const String COURIER = "COURIER";

  static final UTIL_CONST _instance = UTIL_CONST._internal();

  factory UTIL_CONST() {
    return _instance;
  }

  UTIL_CONST._internal();

}