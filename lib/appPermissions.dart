import 'package:android_intent_plus/android_intent.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:littleshops/presentation/common_blocs/simple_bloc_observer.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main.dart';

class AskForPermission extends StatefulWidget {
  @override
  _AskForPermissionState createState() => _AskForPermissionState();
}
class _AskForPermissionState extends State<AskForPermission> {
  //final PermissionHandler permissionHandler = PermissionHandler();
  //Map<PermissionGroup, PermissionStatus> permissions;
  void initState() {
    super.initState();
   // requestLocationPermission();
    _gpsService();
  }
  /*Future<bool> _requestPermission(Permission permission) async {
    final Permission _permissionHandler = Permission();
    var result = await _permissionHandler.request([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }
/*Checking if your App has been Given Permission*/
  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.location);
    if (granted!=true) {
      requestLocationPermission();
    }
    debugPrint('requestContactsPermission $granted');
    return granted;
  }*/
/*Show dialog if GPS not enabled and open settings location*/
  Future _checkGps() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Can't get gurrent location"),
              content:const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                FlatButton(child: Text('Ok'),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                    _gpsService();
                  },
                ),
              ],
            );
          },
        );
      }}}


/*Check if gps service is enabled or not*/
  Future _gpsService() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      abcdef();
      //return true;
  }

  void abcdef() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    Bloc.observer = SimpleBlocObserver();
    await Firebase.initializeApp();
    runApp(MyApp());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ask for permisions'),
          backgroundColor: Colors.red,
        ),
        body: Center(
            child: Column(
              children: <Widget>[
                Text("All Permission Granted"),
              ],
            ))
    );
  }


}

