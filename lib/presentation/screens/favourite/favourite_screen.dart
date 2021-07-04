import 'package:flutter/material.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/navigation_drawer.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text("Little Shops", style: FONT_CONST.TITLE_APPBAR,),
        backgroundColor: COLOR_CONST.primaryColor,
      ),
      body: Container(
        child: Center(
          child: Text("Favourite Page") ,
        ),
      ),
    );
  }

}