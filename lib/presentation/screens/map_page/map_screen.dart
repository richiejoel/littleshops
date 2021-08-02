import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:littleshops/configs/application.dart';

void main() => runApp(MapScreen());

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  String? _mapStyle;

  BitmapDescriptor? customIcon1;
  Set<Marker>? markers;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/maps/map_style.json').then((string) {
      _mapStyle = string;
    });
    markers = Set.from([]);
  }

  createMarker(context) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/images/marker_primary.png')
          .then((icon) {
        setState(() {
          customIcon1 = icon;
        });
      });
    }
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return MaterialApp(
      debugShowCheckedModeBanner: Application.debug,
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(_mapStyle!);
            _controller.complete(controller);
          },
          markers: markers!,
          onTap:  (pos) {
            print(pos);
            Marker f =
            Marker(markerId: MarkerId('1'),
                icon: customIcon1!,
                position: LatLng(-2.1234219, -79.9447695),
                onTap: (){}
                );
            setState(() {
              markers!.add(f);
            });

          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: Text('To the lake!'),
          icon: Icon(Icons.directions_boat),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}