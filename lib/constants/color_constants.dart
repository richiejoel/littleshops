import 'package:flutter/material.dart';

class COLOR_CONST {
  static const primaryColor = Color(0xfff92651);
  static const primaryHoverColor = Color(0xa1ee5e7f);
  static const textColor = Color(0xFF4a4a4a);
  static const cardShadowColor = Color(0xFFd3d1d1);
  static const backgroundColor = Color(0xffF6F7FB);
  static const whiteColor = Colors.white;
  static const borderColor = Color(0xFFd3d1d1);
  static const discountColor = Color(0xFF3084ee);
  static const deleteButtonColor = Color(0xFFeb4d4b);
  static const dividerColor = Colors.black12;

  static final COLOR_CONST _instance = COLOR_CONST._internal();

  factory COLOR_CONST() {
    return _instance;
  }

  COLOR_CONST._internal();
}

const mAnimationDuration = Duration(milliseconds: 200);
