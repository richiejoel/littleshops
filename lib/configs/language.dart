import 'package:flutter/material.dart';

class AppLanguage {
  /// Default Language
  static Locale defaultLanguage = Locale("es");

  /// List language is supported in application
  static List<Locale> supportLanguage = [
    Locale("en"),
    Locale("es"),
  ];

  /// Get default language on phone
  static Locale getLanguageDevice(BuildContext context){
    Locale locale = Localizations.localeOf(context);
    print(locale.languageCode);
    return locale;
  }

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}