import 'package:flutter/material.dart';

class COLOR_CONSTANTS {
  static const primaryColor = Color(0xFFf92651);

  static final COLOR_CONSTANTS _instance = COLOR_CONSTANTS._internal();

  factory COLOR_CONSTANTS() {
    return _instance;
  }

  COLOR_CONSTANTS._internal();
}
