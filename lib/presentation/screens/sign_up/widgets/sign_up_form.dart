import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/util_constants.dart';

import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_bloc.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_event.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/sign_up_event.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/sign_up_state.dart';
import 'package:littleshops/presentation/widgets/buttons/circle_button.dart';
import 'package:littleshops/utils/dialog.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:littleshops/utils/validators.dart';


class SignUpForm extends StatefulWidget {

  final UserModel? intialUser;
  const SignUpForm({Key? key, this.intialUser}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();

}

class _SignUpFormState extends State<SignUpForm>{

  late SignUpBloc signUpBloc;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  @override
  void initState() {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          nameController.text.isNotEmpty;

  bool isRegisterButtonEnabled() {
    return signUpBloc.state.isFormValid &&
        !signUpBloc.state.isSubmitting &&
        isPopulated;
  }

  void onRegister() {
    if (isRegisterButtonEnabled()) {
      UserModel newUser = widget.intialUser!.cloneWith(
        email: emailController.text,
        name: nameController.text,
        role: UTIL_CONST.CUSTOMER,
        token: ""
      );
      signUpBloc.add(
        Submitted(
          newUser: newUser,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
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

        /// Registering
        if (state.isSubmitting) {
          UtilDialog.showWaiting(context);
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
                  Text(
                    Translate.of(context).translate('sign_up'),
                    style: FONT_CONST.SUBTITLE,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 3),
                  _buildNameInput(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildEmailInput(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildPasswordInput(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildConfirmPasswordInput(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildButtonRegister(),
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

  /// Build Name
  _buildNameInput() {
    return TextFormField(
      controller: nameController,
      onChanged: (value) {
        signUpBloc.add(NameChanged(name: value));
      },
      keyboardType: TextInputType.text,
      validator: (_) {
        return !signUpBloc.state.isNameValid
            ? Translate.of(context).translate('invalid_name')
            : null;
      },
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('name'),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  /// Build content
  _buildEmailInput() {
    return TextFormField(
      controller: emailController,
      onChanged: (value) {
        signUpBloc.add(EmailChanged(email: value));
      },
      validator: (_) {
        return !signUpBloc.state.isEmailValid
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

  _buildPasswordInput() {
    return TextFormField(
      controller: passwordController,
      onChanged: (value) {
        signUpBloc.add(PasswordChanged(password: value));
      },
      validator: (_) {
        return !signUpBloc.state.isPasswordValid
            ? Translate.of(context).translate('invalid_password')
            : null;
      },
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
            setState(() {
              isShowPassword = !isShowPassword;
            });
          },
        ),
      ),
    );
  }

  _buildConfirmPasswordInput() {
    return TextFormField(
      controller: confirmPasswordController,
      onChanged: (value) {
        signUpBloc.add(ConfirmPasswordChanged(
          password: passwordController.text,
          confirmPassword: value,
        ));
      },
      validator: (_) {
        return !signUpBloc.state.isConfirmPasswordValid
            ? Translate.of(context).translate('don\'t_match_password')
            : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !isShowConfirmPassword,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('confirm_password'),
        suffixIcon: IconButton(
          icon: isShowConfirmPassword
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
          onPressed: () {
            setState(() {
              isShowConfirmPassword = !isShowConfirmPassword;
            });
          },
        ),
      ),
    );
  }

  _buildButtonRegister() {
    return CircleButton(
      child: Icon(Icons.check, color: Colors.white),
      onPressed: onRegister,
      backgroundColor: isRegisterButtonEnabled()
          ? COLOR_CONST.primaryColor
          : COLOR_CONST.cardShadowColor,
    );
  }


}