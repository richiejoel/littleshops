import 'package:flutter/material.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/image_constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_CONSTANTS.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IMAGE_CONSTANT.SPLASH_SCREEN,
              width: SizeConfig.defaultSize * 15,
              height: SizeConfig.defaultSize * 15,
            ),
            SizedBox(height: SizeConfig.defaultSize),
          ] // Children
        )
      )
    );
  }
}