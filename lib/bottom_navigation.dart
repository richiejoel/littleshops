import 'package:flutter/material.dart';

import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/presentation/screens/shops/shops.dart';
import 'package:littleshops/presentation/widgets/buttons/cart_button.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:littleshops/presentation/screens/home_page/home_screen.dart';
import 'package:littleshops/presentation/screens/map_page/map_screen.dart';
import 'package:littleshops/presentation/screens/map_page/prueba.dart';

import 'navigation_drawer.dart';


class BottomNavigation extends StatefulWidget {
  final int position;
  BottomNavigation({Key? key, this.position = 0}) : super(key: key);

  @override
  _BottomNavigationState createState() {
    return _BottomNavigationState(position: position);
  }
}

class _BottomNavigationState extends State<BottomNavigation>
    with WidgetsBindingObserver {

  final int position;
  _BottomNavigationState({required this.position});

  int selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    selectedIndex = position;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  ///On change tab bottom menu
  void onItemTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Little Shops", style: FONT_CONST.TITLE_APPBAR,),
        backgroundColor: COLOR_CONST.primaryColor,
        actions: [
          CartButton(color: COLOR_CONST.whiteColor),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.message, color: Colors.white,),
          ),
      ],
      ),
      drawer: NavigationDrawer(),
      body: IndexedStack(
        children: [
          HomeScreen(),
          ShopsScreen(),
          MapScreen()
          //PushKitDemoApp()
        ],
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Translate.of(context).translate('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_rounded),
            label: Translate.of(context).translate('shops'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_alt_sharp),
            label: Translate.of(context).translate('map'),
          ),
        ],
        selectedLabelStyle: FONT_CONST.BOLD_DEFAULT,
        selectedItemColor: COLOR_CONST.primaryColor,
        unselectedFontSize: 12,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}