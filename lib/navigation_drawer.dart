import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/util_constants.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_bloc.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_event.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: COLOR_CONST.backgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          //padding: padding,
          children: <Widget>[
            mDrawerHeader(),
            const SizedBox(height: 5,),
            mBuildMenuItem(
                text: 'Home',
                icon: Icons.home,
                onClicked: () => mSelectItem(context, UTIL_CONST.HOME),
            ),
            const SizedBox(height: 5,),
            mBuildMenuItem(
                text: 'Favourites',
                icon: Icons.favorite_border,
                onClicked: () => mSelectItem(context, UTIL_CONST.FAVOURITE),
            ),
            const SizedBox(height: 5,),
            mBuildMenuItem(
                text: 'Workflow',
                icon: Icons.workspaces_outline,
                onClicked: () => mSelectItem(context, UTIL_CONST.PROFILE),
            ),
            const SizedBox(height: 5,),
            mBuildMenuItem(
                text: 'Updates',
                icon: Icons.update,
                onClicked: () => mSelectItem(context, UTIL_CONST.UPDATES),
            ),
            const SizedBox(height: 10,),
            Divider(color: COLOR_CONST.primaryColor,),
            const SizedBox(height: 10,),
            mBuildMenuItem(
                text: 'Log out',
                icon: Icons.exit_to_app_rounded,
              onClicked: () => mSignOut(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget mDrawerHeader(){
    return Container(
      child: UserAccountsDrawerHeader(
        accountName: Text('Richi Joel', style: FONT_CONST.TITLE_DRAWER,),
        accountEmail: Text('juelgarcia98@gmail.com', style: FONT_CONST.SUBTITLE_DRAWER,),
        currentAccountPicture: GestureDetector(
          child: new CircleAvatar(
            backgroundColor: COLOR_CONST.cardShadowColor,
            child: Icon(Icons.person, color: Colors.white,),
          ),
        ),
        decoration: BoxDecoration(
          color: COLOR_CONST.primaryColor,
        ),
      ),
    );
  }


  Widget mBuildMenuItem({required String text,
    required IconData icon, VoidCallback? onClicked}){
    final color = COLOR_CONST.textColor;
    final hoverColor = COLOR_CONST.primaryHoverColor;

    return ListTile(
      tileColor: COLOR_CONST.backgroundColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: color,),
      title: Text(text, style: FONT_CONST.ITEM_MENU,),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void mSelectItem(BuildContext context, String page ){
    Navigator.of(context).pop();
    switch(page){
      case UTIL_CONST.HOME:
        Navigator.pushNamed(context, AppRouter.HOME);
        break;
      case UTIL_CONST.PROFILE:
        Navigator.pushNamed(context, AppRouter.HOME);
        break;
      case UTIL_CONST.FAVOURITE:
        Navigator.pushNamed(context, AppRouter.FAVOURITE);
        break;
    }
  }

  void mSignOut(BuildContext context){
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  }
  

}

