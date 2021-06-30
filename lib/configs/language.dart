import 'package:flutter/material.dart';

class AppLanguage {
  /// Default Language
  static Locale defaultLanguage = Locale("en");

  /// List language is supported in application
  static List<Locale> supportLanguage = [
    Locale("en"),
    Locale("es"),
  ];

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}