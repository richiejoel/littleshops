import 'package:flutter/material.dart';
import 'package:littleshops/constants/color_constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(COLOR_CONST.primaryColor),
        ),
      ),
    );
  }
}
