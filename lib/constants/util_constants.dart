class UTIL_CONST {
  static const String HOME = "HOME";
  static const String PROFILE = "PROFILE";
  static const String FAVOURITE = "FAVOURITE";
  static const String UPDATES = "UPDATES";

  static final UTIL_CONST _instance = UTIL_CONST._internal();

  factory UTIL_CONST() {
    return _instance;
  }

  UTIL_CONST._internal();

}