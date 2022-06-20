import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:littleshops/presentation/common_blocs/simple_bloc_observer.dart';
import 'package:location/location.dart' as loc;

import 'appPermissions.dart';
import 'configs/size_config.dart';
import 'package:littleshops/presentation/common_blocs/common_bloc.dart';
import 'package:littleshops/app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(MyApp());

}

Future initLocation() async {
  loc.Location locationR = loc.Location();
  if (!await locationR.serviceEnabled()) {
    locationR.requestService().then((value) => null);
  }

}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CommonBloc.blocProviders,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return AppView();
            },
          );
        },
      ),
    );
  }
}


