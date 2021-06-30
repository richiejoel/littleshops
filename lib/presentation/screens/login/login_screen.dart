import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/presentation/screens/login/bloc/bloc.dart';
import 'package:littleshops/presentation/screens/login/widgets/login_form.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/configs/size_config.dart';

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
            )
          ),
        ),
      ),
    );
  }

}