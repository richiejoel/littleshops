import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/image_constants.dart';
import 'package:littleshops/constants/util_constants.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_bloc.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_event.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_bloc.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_state.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return Material(
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
                      text: 'My Orders',
                      icon: Icons.shopping_basket,
                      onClicked: () => mSelectItem(context, UTIL_CONST.MY_ORDERS),
                    ),
                    if(state.loggedUser.role == UTIL_CONST.CHIEF) ... [
                      const SizedBox(height: 5,),
                      mBuildMenuItem(
                        text: 'Add Products',
                        icon: Icons.add_business,
                        onClicked: () => mSelectItem(context, UTIL_CONST.ADD_PRODUCTS),
                      ),
                      const SizedBox(height: 5,),
                      mBuildMenuItem(
                        text: 'Add Courier',
                        icon: Icons.person_add,
                        onClicked: () => mSelectItem(context, UTIL_CONST.MY_ORDERS),
                      ),
                    ],
                    const SizedBox(height: 5,),
                    mBuildMenuItem(
                      text: 'Profile',
                      icon: Icons.person,
                      onClicked: () => mSelectItem(context, UTIL_CONST.PROFILE),
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
              );
            }
            return Center(child: Text("Something went wrongs."));
          },
      ),
    );
  }

  Widget mDrawerHeader(){
    return Container(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return UserAccountsDrawerHeader(
              accountName: Text(state.loggedUser.name, style: FONT_CONST.TITLE_DRAWER,),
              accountEmail: Text(state.loggedUser.email, style: FONT_CONST.SUBTITLE_DRAWER,),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: state.loggedUser.avatar.isNotEmpty
                      ? NetworkImage(state.loggedUser.avatar)
                      : AssetImage(IMAGE_CONSTANT.DEFAULT_AVATAR)
                  as ImageProvider<Object>,
                  //backgroundColor: COLOR_CONST.cardShadowColor,
                  //child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: BoxDecoration(
                color: COLOR_CONST.primaryColor,
              ),
            );
          }
          return Center(child: Text("Something went wrongs."));
        },
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
        Navigator.pushNamed(context, AppRouter.PROFILE);
        break;
      case UTIL_CONST.FAVOURITE:
        Navigator.pushNamed(context, AppRouter.FAVOURITE);
        break;
      case UTIL_CONST.MY_ORDERS:
        Navigator.pushNamed(context, AppRouter.MY_ORDERS);
        break;
      case UTIL_CONST.ADD_PRODUCTS:
        Navigator.pushNamed(context, AppRouter.ADD_PRODUCTS);
        break;
    }
  }

  void mSignOut(BuildContext context){
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  }
  

}

