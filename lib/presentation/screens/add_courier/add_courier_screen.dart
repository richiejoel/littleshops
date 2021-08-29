import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/util_constants.dart';
import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/data/repository/auth/auth_repository.dart';
import 'package:littleshops/data/repository/business_repository/business_repository.dart';
import 'package:littleshops/presentation/common_blocs/business/business_bloc.dart';
import 'package:littleshops/presentation/common_blocs/business/business_event.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/sign_up_event.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/sign_up_state.dart';
import 'package:littleshops/presentation/widgets/buttons/cart_button.dart';
import 'package:littleshops/presentation/widgets/buttons/circle_button.dart';
import 'package:littleshops/utils/dialog.dart';
import 'package:littleshops/utils/translate.dart';

import '../../../navigation_drawer.dart';

class AddCourierScreen extends StatefulWidget {


  const AddCourierScreen({Key? key}) : super(key: key);

  @override
  _AddCourierScreenState createState() => _AddCourierScreenState();
}

class _AddCourierScreenState extends State<AddCourierScreen>{

  late SignUpBloc signUpBloc;
  UserModel intialUser =
  UserModel(email: '', id: '', name: '', avatar: '', phoneNumber: '', role: '', addresses: [], token: '');

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  BusinessRepository _businessRepository = BusinessRepository();
  AuthRepository _authRepository = AuthRepository();

  BusinessModel? selectedBusiness;
  List<BusinessModel>? listBusiness;

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  void onBusinessChanged(BuildContext context, BusinessModel business ){
    setState(() {
      selectedBusiness =  business;
    });
  }

  getDropdownItemsBusiness(List<BusinessModel> list) {
    return list
        .map((item) => DropdownMenuItem(child: Text(item.name), value: item))
        .toList();
  }

  @override
  void initState() {
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
      UserModel newUser = intialUser!.cloneWith(
          email: emailController.text,
          name: nameController.text,
          role: UTIL_CONST.COURIER,
          token: ""
      );
      signUpBloc.add(
        SubmittedCourier(
          newUser: newUser,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          businessId: selectedBusiness!.id
        ),
      );
      //_businessRepository.updateCouriersBusiness(selectedBusiness!.id, courier);
    }
  }

  Future<List<BusinessModel>> mGenerateBusiness() async {
    String uid = _authRepository.loggedFirebaseUser.uid;
    List<BusinessModel> business = await _businessRepository
        .fetchBusinessByChief(uid);
    return business!;
    //listBusiness = business;
  }

  Widget mBuildFuture(BuildContext context){
    return FutureBuilder<List<BusinessModel>>(
      future: mGenerateBusiness(),
      builder: (context, snapshot) {
        if (snapshot.hasData!) {
          return _buildBusinessPicker(context, snapshot.data );
          //return Text(snapshot.data);
        } else {
          return Text('awaiting the future');
        }
      },
    );
  }


  @override
  Widget build(BuildContext context)  {

    //mGenerateBusiness();
    BlocProvider.of<BusinessBloc>(context).add(LoadBusiness());
    return BlocProvider(
        create: (context) => SignUpBloc(),
        child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
        /// Success
        if (state.isSuccess) {
          UtilDialog.hideWaiting(context);
          UtilDialog.showInformation(context, content: 'Registro de Courier exitoso!');
          //BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
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
                child: Container(
                  color: COLOR_CONST.backgroundColor,
                  child: Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultPadding,
                      vertical: SizeConfig.defaultSize * 3,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(Translate.of(context).translate('add_courier'), style: FONT_CONST.SUBTITLE_SCREEN),
                          SizedBox(height: SizeConfig.defaultSize * 2),

                          //_buildBusinessPicker(context, listBusiness!),
                          SizedBox(height: SizeConfig.defaultSize),
                          _buildNameInput(context),
                          SizedBox(height: SizeConfig.defaultSize),
                          _buildEmailInput(),
                          SizedBox(height: SizeConfig.defaultSize),
                          _buildPasswordInput(),
                          SizedBox(height: SizeConfig.defaultSize),
                          _buildConfirmPasswordInput(),
                          SizedBox(height: SizeConfig.defaultSize),
                          mBuildFuture(context),
                          SizedBox(height: SizeConfig.defaultSize),
                          _buildButtonRegister(),
                        ],
                      ),
                    ),
                  ),
                ),

              ),
          );
        },
      ),
        ),
    );
  }

  /// Build Name
  _buildNameInput(BuildContext context) {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
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

  _buildBusinessPicker(BuildContext context, List<BusinessModel>? business) {
    return DropdownButtonFormField<BusinessModel>(
      decoration: InputDecoration(
        labelText: Translate.of(context).translate("your_business"),
      ),
      onChanged: (business) => onBusinessChanged(context, business!),
      items: getDropdownItemsBusiness(business!),
      value: business!.isEmpty ? null : selectedBusiness,
    );
  }

}