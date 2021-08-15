import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:littleshops/configs/application.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/presentation/common_blocs/business/business_bloc.dart';
import 'package:littleshops/presentation/common_blocs/business/business_event.dart';
import 'package:littleshops/presentation/common_blocs/business/business_state.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:image/image.dart' as Images;

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
  List<Marker> markersList = [];

  //new
  Uint8List? imageDataBytes;
  var markerIcon;
  GlobalKey iconKey = GlobalKey();

  late ByteData imageData;
  late List<int> bytes;
  var avatarImage;
  var markerImage;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/maps/map_style.json').then((string) {
      _mapStyle = string;
    });
    markers = Set.from([]);
    //WidgetsBinding.instance!.addPostFrameCallback(getCustomMarkerIcon(iconKey));
    WidgetsBinding.instance!.addPostFrameCallback(
            (timeStamp) {getCustomMarkerIcon(iconKey);
            });
  }

  createMarker(context) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          configuration, 'assets/images/marker_primary.png')
          .then((icon) {
        setState(() {
          customIcon1 = icon;
        });
      });
    }
  }
  //-2.19616, -79.88621
  //LatLng(37.42796133580664, -122.085749655962),
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-2.19616, -79.88621),
    zoom: 11.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void mGetMarkers(List<BusinessModel> business) async {
    /*for(int i =0; i > business.length; i++){
      Marker marker = Marker(
          markerId: MarkerId(business[i].id),
          position: LatLng(business[i].latitude, business[i].longitude),
          infoWindow: InfoWindow(title: business[i].name),
          icon: await getMarkerImageFromUrl(business[i].imageUrl, targetWidth: 10)
    );
    markersList.add(marker!);
      setState(() {
        markers!.addAll(markersList);
      });
    }*/
    business.forEach((busy) async {
      Marker marker = Marker(
          markerId: MarkerId(busy.id),
          position: LatLng(busy.latitude, busy.longitude),
          infoWindow: InfoWindow(title: busy.name),
          icon: await getMarkerImageFromUrl(busy.imageUrl, targetWidth: 100),
      );
      markersList.add(marker!);
       setState(() {
        markers!.addAll(markersList);
      });
    });

  }

  @override
  Widget build(BuildContext context)  {
    BlocProvider.of<BusinessBloc>(context).add(LoadBusiness());
    //createMarker(context);
    return BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state) {
          if (state is BusinessLoaded) {
            mGetMarkers(state.allBusiness);
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
                  /*onTap: (pos) {
                    print(pos);
                    Marker f =
                    Marker(markerId: MarkerId('1'),
                        icon: customIcon1!,
                        position: LatLng(-2.1234219, -79.9447695),
                        onTap: () {}
                    );
                    setState(() {
                      markers!.add(f);
                    });
                  },*/
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: _goToTheLake,
                  label: Text('To the lake!'),
                  icon: Icon(Icons.directions_boat),
                ),
              ),
            );
          }
          if (state is BusinessLoading) {
            return Scaffold(
              body: Container(
                color: COLOR_CONST.backgroundColor,
                child: Loading(),
              ),
            );
          }
          return Center(child: Text("Something went wrong."));
        }
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

   Future<BitmapDescriptor> getMarkerImageFromUrl(String url,
  {required int targetWidth}
  ) async {
    assert(url != null);
    final File markerImageFile = await
    DefaultCacheManager().getSingleFile(url);

    if (targetWidth != null) {
      return convertImageFileToBitmapDescriptor(markerImageFile,
          size: targetWidth);
    } else {
      Uint8List markerImageBytes = await markerImageFile.readAsBytes();
      return BitmapDescriptor.fromBytes(markerImageBytes);
    }
  }

  static Future<BitmapDescriptor> convertImageFileToBitmapDescriptor(
      File imageFile,
      {int size = 100,
        bool addBorder = true,
        Color borderColor = Colors.red,
        double borderSize = 40,
        Color titleColor = Colors.blue,
        Color titleBackgroundColor = Colors.blue}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()
      ..color;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final double radius = size / 2;

    //make canvas clip path to prevent image drawing over the circle
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        Radius.circular(100)));
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(size / 2.toDouble(), size + 20.toDouble(), 10, 10),
        Radius.circular(100)));
    canvas.clipPath(clipPath);

    //new
    final center = Offset(50, 50);
    Paint paintCircle = Paint()..color = Colors.black;
    Paint paintBorder = Paint()
      ..color = COLOR_CONST.primaryColor
      ..strokeWidth = 50
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);
    //canvas.drawPaint(paintBorder);

    //paintImage
    final Uint8List imageUint8List = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        image: imageFI.image);

    //convert canvas as PNG bytes
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final data = await _image.toByteData(format: ui.ImageByteFormat.png);

    //convert PNG bytes as BitmapDescriptor
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  Future<void> getCustomMarkerIcon(GlobalKey iconKey) async {
    RenderRepaintBoundary? boundary = iconKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    setState(() {
      markerIcon = BitmapDescriptor.fromBytes(pngBytes);
    });

  }

  Future<List<int>> makeReceiptImage() async {
    // load avatar image
    ByteData imageData = await rootBundle.load('assets/av.png');
    List<int> bytes = Uint8List.view(imageData.buffer);
    var avatarImage = Images.decodeImage(bytes);

    //load marker image
    imageData = await rootBundle.load('assets/ma.png');
    bytes = Uint8List.view(imageData.buffer);
    var markerImage = Images.decodeImage(bytes);

    //resize the avatar image to fit inside the marker image
    avatarImage = Images.copyResize(avatarImage!,
        width: markerImage!.width ~/ 1.1, height: markerImage.height ~/ 1.4);


    var radius = 90;
    int originX = avatarImage.width ~/ 2, originY = avatarImage.height ~/ 2;

    //draw the avatar image cropped as a circle inside the marker image
    for (int y = -radius; y <= radius; y++)
      for (int x = -radius; x <= radius; x++)
        if (x * x + y * y <= radius * radius)
          markerImage!.setPixelSafe(originX + x+8, originY + y+10,
              avatarImage.getPixelSafe(originX + x, originY + y));

    return Images.encodePng(markerImage!);
  }

}