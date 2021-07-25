import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_bloc.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_state.dart';
import 'package:littleshops/presentation/screens/profile/profile_header.dart';
import 'package:littleshops/presentation/widgets/buttons/cart_button.dart';
import 'package:littleshops/utils/translate.dart';

import '../../../navigation_drawer.dart';

class ProfileScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawer(),
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
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileHeader(),
                            _buildNameInput(context, state.loggedUser),
                            _buildEmailInput(context, state.loggedUser),
                            _buildPhoneNumberInput(context, state.loggedUser),
                          ],
                        ),
                      ),
                  );
                }
                return Center(child: Text("Something went wrongs."));
              },
          ),
        )
    );
  }


  /// Build Name
  _buildNameInput(BuildContext context, UserModel loggedUser) {
    return Container(
      margin:
      EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultPadding,
        vertical: SizeConfig.defaultSize * 3,
      ),
      child: TextFormField(
        controller: nameController..text= loggedUser.name ,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: Translate.of(context).translate('name'),
          suffixIcon: Icon(Icons.person_outline),
        ),
      ),
    );
  }

  /// Build Email
  _buildEmailInput(BuildContext context, UserModel loggedUser) {
    return Container(
      margin:
      EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultPadding,
        //vertical: SizeConfig.defaultSize * 3,
      ),
      child: TextFormField(
        readOnly: true,
        controller: emailController..text= loggedUser.email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: Translate.of(context).translate('email'),
          suffixIcon: Icon(Icons.email_outlined),
        ),
      ),
    );
  }

  /// Build Phone Number
  _buildPhoneNumberInput(BuildContext context, UserModel loggedUser) {
    return Container(
      margin:
      EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultPadding,
        vertical: SizeConfig.defaultSize * 3,
      ),
      child: TextFormField(
        //initialValue: loggedUser.phoneNumber,
        controller: phoneNumberController..text= loggedUser.phoneNumber,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: Translate.of(context).translate('phone_number'),
          suffixIcon: Icon(Icons.phone),
        ),
      ),
    );
  }


}