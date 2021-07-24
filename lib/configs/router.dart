import 'package:flutter/material.dart';
import 'package:littleshops/data/model/order_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/presentation/screens/cart/cart_screen.dart';
import 'package:littleshops/presentation/screens/delivery_address/delivery_address_screen.dart';
import 'package:littleshops/presentation/screens/detail_order/detail_order_screen.dart';
import 'package:littleshops/presentation/screens/detail_product/detail_product_screen.dart';
import 'package:littleshops/presentation/screens/favourite/favourite_screen.dart';
import 'package:littleshops/presentation/screens/profile_page/profile_screen.dart';
import 'package:littleshops/presentation/screens/sign_up/sign_up_screen.dart';

import 'package:littleshops/presentation/screens/splash_screen/splash_screen.dart';
import 'package:littleshops/presentation/screens/login/login_screen.dart';
import 'package:littleshops/bottom_navigation.dart';

class AppRouter {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String INITIALIZE_INFO = '/initialize_info';
  static const String REGISTER = '/register';
  static const String HOME = '/home';
  static const String FAVOURITE = '/favourite';
  static const String DETAIL_PRODUCT = '/detail_product';
  static const String CART = '/cart';
  static const String DELIVERY_ADDRESS = '/deleviry_address';
  static const String DETAIL_ORDER = '/detail_order';

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
        var initialUser = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => SignUpScreen(initialUser: initialUser),
            );
      case HOME:
        return MaterialPageRoute(
          builder: (_) => BottomNavigation(),
        );
      case FAVOURITE:
        return MaterialPageRoute(
          builder: (_) => FavouriteScreen(),
        );
      case DETAIL_PRODUCT:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => DetailProductScreen(product: product),
        );
      case CART:
        return MaterialPageRoute(
          builder: (_) => CartScreen(),
        );
      case DELIVERY_ADDRESS:
        return MaterialPageRoute(
          builder: (_) => DeliveryAddressModelScreen(),
        );
      case DETAIL_ORDER:
        var order = settings.arguments as OrderModel;
        return MaterialPageRoute(
            builder: (_) => DetailOrderScreen(order: order));
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


    //DELIVERY_ADDRESS
  ///Singleton factory
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();
}
