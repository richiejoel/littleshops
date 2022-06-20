import 'package:android_intent_plus/android_intent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:littleshops/data/model/order_model.dart';
import 'package:littleshops/data/repository/auth/auth_repository.dart';
import 'package:littleshops/data/repository/order_repository/order_repository.dart';
import 'package:huawei_push/huawei_push.dart' as Huawei;
import 'package:huawei_analytics/huawei_analytics.dart' as AnalyticsHuawei;
import 'package:location/location.dart' as loc;

import 'package:littleshops/presentation/common_blocs/cart/bloc.dart';
import 'package:littleshops/presentation/common_blocs/common_bloc.dart';
import 'package:littleshops/presentation/common_blocs/application/bloc.dart';
import 'package:littleshops/presentation/common_blocs/authentication/bloc.dart';
import 'package:littleshops/presentation/common_blocs/language/bloc.dart';
import 'package:littleshops/configs/application.dart';
import 'package:littleshops/configs/theme.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/configs/language.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_bloc.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_event.dart';
import 'package:littleshops/presentation/screens/detail_order/detail_order_screen.dart';
import 'package:littleshops/utils/translate.dart';

import 'configs/HuaweiManager.dart';
import 'data/repository/user_repository/user_repository.dart';


class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();

}

class _AppViewState extends State<AppView> {

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;

  String _token = '';

  //ini rjgman
  //BusinessRepository _businessRepository = BusinessRepository();
  AuthRepository _authRepository = AuthRepository();
  OrderRepository _orderRepository = OrderRepository();
  UserRepository _userRepository = UserRepository();
  String orderId = "";
  OrderModel? orderModel;
  String? selectedNotificationPayload;
  //fin rjgman

  //ini rjgman
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  //huawei Analytics
  //final AnalyticsHuawei.HMSAnalytics hmsAnalytics = new AnalyticsHuawei.HMSAnalytics();

  void mPrueba() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
  //fin rjgman

  void mPP() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails!.payload;
    }
  }

  @override
  void initState()   {
    super.initState();

    CommonBloc.applicationBloc.add(SetupApplication());
    mPP();
    mPrueba();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);


    //ini rjgman
    messaging.getInitialMessage()
        .then((value) => print(value!.data.values.elementAt(0)));
    messaging.getToken().then((value){
      _userRepository.updateOneDataUser(_authRepository.loggedFirebaseUser.uid, "token", value!);
    });
    messaging.subscribeToTopic("Events");
    mConfigureCallBacks();
    //fin rjgman
    initAnalyticsHuawei();
    Huawei.Push.enableLogger();
    Huawei.Push.disableLogger();
    initPlatformState();

  }

  Future initLocation() async {
    loc.Location locationR = loc.Location();
    if (!await locationR.serviceEnabled()) {
       locationR.requestService();
    }

  }

  Future<void> initAnalyticsHuawei() async {
    await HuaweiAnalyticsManager.instance.hmsAnalytics.enableLog();
    await HuaweiAnalyticsManager.instance.hmsAnalytics.enableLogger();
    await HuaweiAnalyticsManager.instance.hmsAnalytics.setAnalyticsEnabled(true);
    await HuaweiAnalyticsManager.instance.hmsAnalytics.enableLogWithLevel("DEBUG");
    await HuaweiAnalyticsManager.instance.hmsAnalytics.setUserId(_authRepository.loggedFirebaseUser.uid);
    await HuaweiAnalyticsManager.instance.hmsAnalytics.setUserProfile("Email", _authRepository.loggedFirebaseUser.email!!);

  }

  // ini rjgman
 /* Future<bool> getCourierID(String businessId) async {
    final loggedFirebaseUser = _authRepository.loggedFirebaseUser;
    UserModel user = await _userRepository.getUserById(loggedFirebaseUser.uid);
    if(user.role != UTIL_CONST.COURIER){
      return false;
    }
    BusinessModel model = await _businessRepository.fetchCouriersByBusinessID(businessId);
    for(int i=0; i<model.couriers.length; i++){
      if(loggedFirebaseUser.uid == model.couriers.elementAt(i)){
        return true;
      }
      //return loggedFirebaseUser.uid == model.couriers.elementAt(i);
    }
    return false;
  }*/

  Future<void> initPlatformState() async {
    if (!mounted) return;
    Huawei.Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
    Huawei.Push.getIntentStream.listen(_onNewIntent, onError: _onIntentError);
    Huawei.Push.onNotificationOpenedApp.listen(_onNotificationOpenedApp);
    String result = await Huawei.Push.subscribe("shops");
    dynamic initialNotification = await Huawei.Push.getInitialNotification();
    _onNotificationOpenedApp(initialNotification);
    String? intent = await Huawei.Push.getInitialIntent();
    _onNewIntent(intent);
    Huawei.Push.onMessageReceivedStream.listen(
      _onMessageReceived,
      onError: _onMessageReceiveError,
    );
    Huawei.Push.getRemoteMsgSendStatusStream.listen(
      _onRemoteMessageSendStatus,
      onError: _onRemoteMessageSendError,
    );
    bool backgroundMessageHandler = await Huawei.Push.registerBackgroundMessageHandler(
      backgroundMessageCallback!!,
    );
    debugPrint(
      'backgroundMessageHandler registered: $backgroundMessageHandler',
    );
  }


  void _onTokenEvent(String event) {
    _token = event;
    print('Hola -> ' + _token);
    showResult('TokenEvent', _token);
  }

  void _onTokenError(Object error) {
    PlatformException e = error as PlatformException;
    showResult('TokenErrorEvent', e.message!);
  }

  void _onMessageReceived(Huawei.RemoteMessage remoteMessage) {
    String? data = remoteMessage.data;
    if (data != null) {
      Huawei.Push.localNotification(
        <String, String>{
          Huawei.HMSLocalNotificationAttr.TITLE: 'DataMessage Received',
          Huawei.HMSLocalNotificationAttr.MESSAGE: data,
        },
      );
      showResult('onMessageReceived', 'Data: ' + data);
    } else {
      showResult('onMessageReceived', 'No data is present.');
    }
  }

  void _onMessageReceiveError(Object error) {
    showResult('onMessageReceiveError', error.toString());
  }

  void _onRemoteMessageSendStatus(String event) {
    showResult('RemoteMessageSendStatus', 'Status: ' + event.toString());
  }

  void _onRemoteMessageSendError(Object error) {
    PlatformException e = error as PlatformException;
    showResult('RemoteMessageSendError', 'Error: ' + e.toString());
  }

  void _onNewIntent(String? intentString) {
    // For navigating to the custom intent page (deep link) the custom
    // intent that sent from the push kit console is:
    // app://app2
    intentString = intentString ?? '';
    if (intentString != '') {
      //showResult('CustomIntentEvent: ', intentString);
      List<String> parsedString = intentString.split('://');
      if (parsedString[1] == 'app2') {
        SchedulerBinding.instance?.addPostFrameCallback(
              (Duration timeStamp) {
            Navigator.of(context).push(MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const CustomIntentPage(),
            ));
          },
        );
      }
    }
  }

  void _onIntentError(Object err) {
    PlatformException e = err as PlatformException;
    debugPrint('Error on intent stream: ' + e.toString());
  }

  void _onNotificationOpenedApp(dynamic initialNotification) {
    if (initialNotification != null) {
      showResult('onNotificationOpenedApp', initialNotification.toString());
    }
  }

  void backgroundMessageCallback(Huawei.RemoteMessage remoteMessage) async {
    String? data = remoteMessage.data;
    if (data != null) {
      debugPrint(
        'Background message is received, sending local notification.',
      );
      Huawei.Push.localNotification(
        <String, String>{
          Huawei.HMSLocalNotificationAttr.TITLE: '[Headless] DataMessage Received',
          Huawei.HMSLocalNotificationAttr.MESSAGE: data,
        },
      );
    } else {
      debugPrint(
        'Background message is received. There is no data in the message.',
      );
    }
  }

  void showResult(
      String name, [
        String? msg = 'Button pressed.',
      ]) {
    msg ??= '';
    debugPrint('[' + name + ']' + ': ' + msg);
    Huawei.Push.showToast('[' + name + ']: ' + msg);
  }


  Future<dynamic> onSelectNotification(payload) async {
    // implement the navigation logic
    orderModel = await _orderRepository.getOrderById(payload);
    selectedNotificationPayload = payload;
    this._navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => DetailOrderScreen(order: orderModel!,)),
          (Route<dynamic> route) => false,
    );
  }

  mGoToPageSpecific(payload) async {
    orderModel = await _orderRepository.getOrderById(payload);
    selectedNotificationPayload = payload;
    this._navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => DetailOrderScreen(order: orderModel!,)),
          (Route<dynamic> route) => false,
    );
  }

  void initPushNotification(){
    FirebaseMessaging.instance.getInitialMessage()
        .then((RemoteMessage? message) {
      if (message == null) return;
      /*if(!(getCourierID(message.data['info']) as bool)) {
        messaging.unsubscribeFromTopic("Events");
      }*/
      print("You're so fucking fake -> " + message.data['order']);
      mGoToPageSpecific(message.data['order']);

    });
  }

  void mConfigureCallBacks(){



    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      /*if(!(getCourierID(message.data['info']) as bool)) {
        messaging.unsubscribeFromTopic("Events");
      }*/
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      orderId = message.data['order'] as String;
      //if(getCourierID(message.data['info'] as String) as bool){
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                ),

              ),
            payload: orderId,
          );
        }
      //mGoToPageSpecific(orderId);
      //}

    });

    /*FirebaseMessaging.onBackgroundMessage((message) async  {

      orderModel = await _orderRepository.getOrderById('03b52f00-ed7e-11eb-91c5-97a77921cbb4');
      this._navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DetailOrderScreen(order: orderModel!,)),
            (Route<dynamic> route) => false,
      );

      /*return Navigator.pushNamed(
        context,
        AppRouter.DETAIL_ORDER, //Detail Order
        arguments: orderModel,
      );*/
    });*/

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)  {
      print('A new onMessageOpenedApp event was published!');
      /*if(!(getCourierID(message.data['info']) as bool)) {
        messaging.unsubscribeFromTopic("Events");
      }*/
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      orderId = message.data['order'] as String;
      //if(getCourierID(message.data['info'] as String) as bool){
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
              ),
            ),
          payload: orderId,
        );
      }
      //}

    });

  }
  // fin rjgman

  void onNavigate(String route) {
    _navigator!.pushNamedAndRemoveUntil(route, (route) => false);
  }

  void loadData() {
    // Only load data when authenticated
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
    BlocProvider.of<CartBloc>(context).add(LoadCart());
    //NotificationsMessaging ms = NotificationsMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, applicationState) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: _navigatorKey,
              debugShowCheckedModeBanner: Application.debug,
              title: Application.title,
              theme: AppTheme.currentTheme,
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: AppRouter.SPLASH,
              supportedLocales: AppLanguage.supportLanguage,
              localizationsDelegates: [
                Translate.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: AppLanguage.defaultLanguage,
              builder: (context, child) {
                 initLocation();
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, authState) {
                    if (applicationState is ApplicationCompleted) {
                      if (authState is Unauthenticated) {
                        onNavigate(AppRouter.LOGIN);
                      } else if (authState is Uninitialized) {
                        onNavigate(AppRouter.SPLASH);
                      } else if (authState is Authenticated) {
                        loadData();
                        onNavigate(AppRouter.HOME);
                        initPushNotification();
                      }
                    } else {
                      onNavigate(AppRouter.SPLASH);
                    }
                  },
                  child: child,
                );
              },
            );
          },
        );
      },
    );
  }

}

class CustomIntentPage extends StatelessWidget {
  const CustomIntentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Push Kit Demo - Custom Intent URI Page',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://developer.huawei.com/dev_index/img/bbs_en_logo.png?v=123',
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Page to be opened with Custom Intent URI',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}