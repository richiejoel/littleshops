import 'package:flutter/material.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';

class AppTheme {
  static final ThemeData currentTheme = ThemeData(
    scaffoldBackgroundColor: COLOR_CONST.backgroundColor,
    fontFamily: "Roboto",
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: COLOR_CONST.primaryColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: _inputDecorationThem,
  );

  static final _appBarTheme = AppBarTheme(
    //color: COLOR_CONST.primaryColor,
    backgroundColor: COLOR_CONST.primaryColor,
    shadowColor: COLOR_CONST.cardShadowColor,
    elevation: 0.4,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: COLOR_CONST.whiteColor),
    actionsIconTheme: IconThemeData(color: COLOR_CONST.primaryHoverColor),
    centerTitle: true,
    textTheme: TextTheme(headline6: FONT_CONST.BOLD_DEFAULT_20),
  );

  static final _textTheme = TextTheme(
    bodyText1: TextStyle(color: COLOR_CONST.textColor),
    bodyText2: TextStyle(color: COLOR_CONST.textColor),
  );

  static final _inputDecorationThem = InputDecorationTheme(
    contentPadding:
    EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding * 1.2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: COLOR_CONST.textColor),
    ),
    hintStyle: FONT_CONST.REGULAR_DEFAULT_20,
  );

  /// Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}