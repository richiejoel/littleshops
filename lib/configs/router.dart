import 'package:flutter/material.dart';

import 'package:littleshops/presentation/screens/splashScreen/splash_screen.dart';
import 'package:littleshops/presentation/screens/login/login_screen.dart';
import 'package:littleshops/bottom_navigation.dart';

class AppRouter {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String INITIALIZE_INFO = '/initialize_info';
  static const String REGISTER = '/register';
  static const String HOME = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(
          builder: (_) => SplashScreen()
        );
      case LOGIN:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      // case FORGOT_PASSWORD:
      //   return MaterialPageRoute(builder: (_) => ForgotPasswordScreen(),);
      case INITIALIZE_INFO:
        return MaterialPageRoute(
          builder: (_) => Text("hola"),
        );
      case REGISTER:
        //var initialUser = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) =>
                Text("hola") //RegisterScreen(initialUser: initialUser),
            );
      case HOME:
        return MaterialPageRoute(
          builder: (_) => BottomNavigation(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  ///Singleton factory
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();
}
