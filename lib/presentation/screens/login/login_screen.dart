import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/presentation/screens/login/bloc/bloc.dart';
import 'package:littleshops/presentation/screens/login/widgets/login_form.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/utils/translate.dart';

class LoginScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: COLOR_CONST.primaryColor,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: SizeConfig.defaultSize * 15,
                      bottom: SizeConfig.defaultSize * 3,
                      right: SizeConfig.defaultSize * 1.5,
                      left: SizeConfig.defaultSize * 1.5,
                    ),
                    child:Text("Little Shops", textAlign: TextAlign.center,
                      style: FONT_CONST.TITLE,
                    ) ,
                  ),
                  LoginForm(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildNoAccountText(context),
        ),
      ),
    );
  }

  _buildNoAccountText(context) {
    UserModel initialUser = UserModel(
      id: "",
      email: "",
      avatar: "",
      addresses: [],
      name: "",
      phoneNumber: "",
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Translate.of(context).translate('don\'t_have_an_account'),
            style: FONT_CONST.REGULAR_DEFAULT_20
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              AppRouter.REGISTER,
              arguments: initialUser
            ),
            child: Text(
              Translate.of(context).translate('register'),
              style: TextStyle(color: Colors.white )//FONT_CONST.BOLD_PRIMARY_20,
            ),
          ),
        ],
      ),
    );
  }

}