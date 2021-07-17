import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/presentation/common_blocs/application/application_bloc.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_bloc.dart';

import 'package:littleshops/presentation/common_blocs/language/language_bloc.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_bloc.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_bloc.dart';

class CommonBloc {

  static final languageBloc = LanguageBloc();
  static final authenticationBloc = AuthenticationBloc();
  static final applicationBloc = ApplicationBloc();
  static final cartBloc = CartBloc();
  static final profileBloc = ProfileBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AuthenticationBloc>(
      create: (context) => authenticationBloc,
    ),
    BlocProvider<LanguageBloc>(
      create: (context) => languageBloc,
    ),
    BlocProvider<CartBloc>(
      create: (context) => cartBloc,
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => profileBloc,
    ),

  ];

  static void dispose(){
    languageBloc.close();
    authenticationBloc.close();
    applicationBloc.close();
    cartBloc.close();
    profileBloc.close();

  }

  //Singleton Factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc(){
    return _instance;
  }

  CommonBloc._internal();

}