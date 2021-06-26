import 'package:flutter/material.dart';
import 'package:littleshops/constants/ColorConstants.dart';
import 'package:littleshops/configs/SizeConfig.dart';

class SplashScreen extends StatelessWidget {
  const name({Key? key}) : super(key: key);

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
        )
      )
    );
  }
}