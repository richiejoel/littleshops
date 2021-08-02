import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:littleshops/presentation/common_blocs/common_bloc.dart';
import 'package:littleshops/presentation/common_blocs/application/bloc.dart';
import 'package:littleshops/presentation/common_blocs/authentication/bloc.dart';
import 'package:littleshops/configs/application.dart';
import 'package:littleshops/data/local/pref.dart';
import 'package:littleshops/presentation/common_blocs/language/bloc.dart';


class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final Application application = Application();

  ApplicationBloc() : super(ApplicationInitial());

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is SetupApplication) {
      /// Setup SharedPreferences
      await application.setPreferences();
      Position position = await application.determinePosition();
      print("LOCATION -> " + position.latitude.toString() + " - " +position.longitude.toString());

      /// Get old settings
      final oldLanguage = LocalPref.getString("language");

      if (oldLanguage != null) {
        CommonBloc.languageBloc.add(LanguageChanged(Locale(oldLanguage)));
      }

      /// Authentication begin check
      CommonBloc.authenticationBloc.add(AuthenticationStarted());

      yield ApplicationCompleted();
    }
  }
}
