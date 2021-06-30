import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/presentation/common_blocs/application/application_bloc.dart';

import 'package:littleshops/presentation/common_blocs/language/language_bloc.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_bloc.dart';

class CommonBloc {

  static final languageBloc = LanguageBloc();
  static final authenticationBloc = AuthenticationBloc();
  static final applicationBloc = ApplicationBloc();

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

  ];

  static void dispose(){

  }

  //Singleton Factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc(){
    return _instance;
  }

  CommonBloc._internal();

}