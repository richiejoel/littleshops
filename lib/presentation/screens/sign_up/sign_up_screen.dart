import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/bloc.dart';
import 'package:littleshops/presentation/screens/sign_up/widgets/sign_up_form.dart';
import 'package:littleshops/utils/translate.dart';

class SignUpScreen extends StatelessWidget{

  final UserModel initialUser;

  const SignUpScreen({Key? key, required this.initialUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: COLOR_CONST.primaryColor,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: SizeConfig.defaultSize * 8,
                    bottom: SizeConfig.defaultSize * 3,
                    right: SizeConfig.defaultSize * 1.5,
                    left: SizeConfig.defaultSize * 1.5,
                  ),
                  child:Text("Little Shops", textAlign: TextAlign.center,
                    style: FONT_CONST.TITLE,
                  ) ,
                ),
                SignUpForm(intialUser: initialUser),
              ],
            ),
          ),
          bottomNavigationBar: _buildHaveAccountText(context),
        ),
      ),
    );
  }

  _buildHaveAccountText(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Translate.of(context).translate('already_have_an_account'),
            style: FONT_CONST.REGULAR_DEFAULT_20,
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.LOGIN,
                  (_) => false,
            ),
            child: Text(
              Translate.of(context).translate('login'),
              style: FONT_CONST.BOLD_PRIMARY_20,
            ),
          ),
        ],
      ),
    );
  }


}