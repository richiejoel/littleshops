import 'package:flutter/material.dart';

import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';

class FONT_CONST {
  static final REGULAR = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontSize: SizeConfig.defaultSize * 1.4,
  );

  static final MEDIUM = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: SizeConfig.defaultSize * 1.4,
  );

  static final BOLD = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: SizeConfig.defaultSize * 1.4,
  );

  static final TITLE = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: SizeConfig.defaultSize * 5,
  );

  static final TITLE_APPBAR = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: SizeConfig.defaultSize * 3,
  );

  static final TITLE_DRAWER = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: SizeConfig.defaultSize * 2.2,
  );

  static final SUBTITLE_DRAWER = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontSize: SizeConfig.defaultSize * 1.5,
  );

  static final SUBTITLE = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: COLOR_CONST.primaryColor,
    fontSize: SizeConfig.defaultSize * 3,
  );

  static final SUBTITLE_SCREEN = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: COLOR_CONST.primaryColor,
    fontSize: SizeConfig.defaultSize * 2,
  );

  static final ITEM_MENU = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: COLOR_CONST.textColor,
    fontSize: SizeConfig.defaultSize * 2,
  );

  static final LOGIN_TEXT = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    color: COLOR_CONST.whiteColor,
    fontSize: SizeConfig.defaultSize * 1.4,
  );

  static final LOGIN_TEXT_EVENT = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: COLOR_CONST.whiteColor,
    fontSize: SizeConfig.defaultSize * 1.5,
  );

  static final CATEGORY_TEXT = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: COLOR_CONST.whiteColor,
    fontSize: SizeConfig.defaultSize * 1.7,
      shadows: [
        Shadow( // bottomLeft
            offset: Offset(-1.5, -1.5),
            color: Colors.black
        ),
        Shadow( // bottomRight
            offset: Offset(1.5, -1.5),
            color: Colors.black
        ),
        Shadow( // topRight
            offset: Offset(1.5, 1.5),
            color: Colors.black
        ),
        Shadow( // topLeft
            offset: Offset(-1.5, 1.5),
            color: Colors.black
        ),
      ]
  );

  //REGULAR
  static final REGULAR_DEFAULT = REGULAR.copyWith(color: COLOR_CONST.textColor);
  static final REGULAR_DEFAULT_16 =
  REGULAR_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final REGULAR_DEFAULT_18 =
  REGULAR_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final REGULAR_DEFAULT_20 =
  REGULAR_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2);

  static final REGULAR_PRIMARY =
  REGULAR.copyWith(color: COLOR_CONST.primaryColor);
  static final REGULAR_PRIMARY_16 =
  REGULAR_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final REGULAR_PRIMARY_18 =
  REGULAR_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final REGULAR_PRIMARY_20 =
  REGULAR_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2);

  static final REGULAR_WHITE = REGULAR.copyWith(color: Colors.white);
  static final REGULAR_WHITE_16 =
  REGULAR_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final REGULAR_WHITE_18 =
  REGULAR_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final REGULAR_WHITE_20 =
  REGULAR_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 2);

  //MEDIUM (SEMIBOLD)
  static final MEDIUM_DEFAULT = MEDIUM.copyWith(color: COLOR_CONST.textColor);
  static final MEDIUM_DEFAULT_16 =
  MEDIUM_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final MEDIUM_DEFAULT_18 =
  MEDIUM_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final MEDIUM_DEFAULT_20 =
  MEDIUM_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2);

  static final MEDIUM_PRIMARY =
  MEDIUM.copyWith(color: COLOR_CONST.primaryColor);
  static final MEDIUM_PRIMARY_16 =
  MEDIUM_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final MEDIUM_PRIMARY_18 =
  MEDIUM_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final MEDIUM_PRIMARY_20 =
  MEDIUM_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2);
  static final MEDIUM_PRIMARY_24 =
  MEDIUM_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2.4);

  static final MEDIUM_WHITE = MEDIUM.copyWith(color: Colors.white);
  static final MEDIUM_WHITE_16 =
  MEDIUM_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final MEDIUM_WHITE_18 =
  MEDIUM_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final MEDIUM_WHITE_20 =
  MEDIUM_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 2);

  //BOLD
  static final BOLD_DEFAULT = BOLD.copyWith(color: COLOR_CONST.textColor);
  static final BOLD_DEFAULT_16 =
  BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final BOLD_DEFAULT_18 =
  BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final BOLD_DEFAULT_20 =
  BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2);
  static final BOLD_DEFAULT_24 =
  BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2.4);
  static final BOLD_DEFAULT_26 =
  BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2.6);

  static final BOLD_PRIMARY = BOLD.copyWith(color: COLOR_CONST.primaryColor);
  static final BOLD_PRIMARY_16 =
  BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final BOLD_PRIMARY_18 =
  BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final BOLD_PRIMARY_20 =
  BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2);
  static final BOLD_PRIMARY_24 =
  BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2.4);
  static final BOLD_PRIMARY_26 =
  BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2.6);

  static final BOLD_WHITE = BOLD.copyWith(color: Colors.white);
  static final BOLD_WHITE_16 =
  BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final BOLD_WHITE_18 =
  BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final BOLD_WHITE_20 =
  BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 2);
  static final BOLD_WHITE_26 =
  BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 2.6);
  static final BOLD_WHITE_32 =
  BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 3.2);

  ///Singleton factory
  static final FONT_CONST _instance = FONT_CONST._internal();

  factory FONT_CONST() {
    return _instance;
  }

  FONT_CONST._internal();
}