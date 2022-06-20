import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/HuaweiManager.dart';

import 'package:littleshops/presentation/screens/login/bloc/bloc.dart';
import 'package:littleshops/presentation/common_blocs/authentication/bloc.dart';
import 'package:littleshops/utils/dialog.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:littleshops/presentation/widgets/buttons/circle_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late LoginBloc loginBloc;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isShowPassword = false;



  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled() {
    return loginBloc.state.isFormValid &&
        !loginBloc.state.isSubmitting &&
        isPopulated;
  }

  void onLogin() {
    if (isLoginButtonEnabled()) {
      analyticsLogin();
      loginBloc.add(LoginWithCredential(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }

  void analyticsLogin() async {
    Map<String, dynamic> customEvent = {
      "email": emailController.text
    };
    await HuaweiAnalyticsManager.instance.hmsAnalytics.onEvent("Login", customEvent);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        /// Success
        if (state.isSuccess) {
          UtilDialog.hideWaiting(context);
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }

        /// Failure
        if (state.isFailure) {
          UtilDialog.hideWaiting(context);
          UtilDialog.showInformation(context, content: state.message);
        }

        /// Logging
        if (state.isSubmitting) {
          UtilDialog.showWaiting(context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            margin:
            EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultPadding,
              vertical: SizeConfig.defaultSize * 3,
            ),
            child: Form(
              child: Column(
                children: <Widget>[
                  Text("Iniciar Sesión", style: FONT_CONST.SUBTITLE,),
                  SizedBox(height: SizeConfig.defaultSize * 3),
                  _buildTextFieldUsername(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildTextFieldPassword(),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      Translate.of(context).translate('forgot_password'),
                      style: FONT_CONST.REGULAR_DEFAULT_18,
                    ),
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildButtonLogin(state),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  /// Build content
  _buildTextFieldUsername() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: emailController,
      onChanged: (value) {
        loginBloc.add(EmailChanged(email: value));
      },
      validator: (_) {
        return !loginBloc.state.isEmailValid
            ? Translate.of(context).translate('invalid_email')
            : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('email'),
        suffixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  _buildTextFieldPassword() {
    return TextFormField(
      controller: passwordController,
      textInputAction: TextInputAction.go,
      onChanged: (value) {
        loginBloc.add(PasswordChanged(password: value));
      },
      validator: (_) {
        return !loginBloc.state.isPasswordValid
            ? Translate.of(context).translate('invalid_password')
            : null;
      },
      onEditingComplete: onLogin,
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !isShowPassword,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('password'),
        suffixIcon: IconButton(
          icon: isShowPassword
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
          onPressed: () {
            setState(() => isShowPassword = !isShowPassword);
          },
        ),
      ),
    );
  }

  _buildButtonLogin(LoginState state) {
    return CircleButton(
      child: Icon(Icons.arrow_forward_rounded, color: Colors.white),
      onPressed: onLogin,
      backgroundColor: isLoginButtonEnabled()
          ? COLOR_CONST.primaryColor
          : COLOR_CONST.cardShadowColor,
    );
  }


}