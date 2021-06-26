import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBloc {

  static final List<BlocProvider> blocProviders = [];

  static void dispose(){

  }

  //Singleton Factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc(){
    return _instance;
  }

  CommonBloc._internal();

}