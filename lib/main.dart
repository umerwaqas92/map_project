import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import 'dart:io';
import 'package:image/image.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  var icon;
  var icon2;
  var icon3;


  Set<Marker> markers=Set();







  getIcon(path) async {
//    icon2= await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10,10)), 'asstes/icon1.png');

//    var icon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(),
//        "asstes/icon2.png");
//    setState(() {
//      this.icon = icon;
//    });

    var icon2 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),path);
    return icon2;
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );


  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(32.9649791, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);




  Future<void> addmarker(id,List<String> images,LatLng location) async {

    var icon =await getIcon(images.last);
    var marker =     Marker(
            position: location,
            markerId: MarkerId(id),
            icon: icon,
            infoWindow: InfoWindow(
             title:  "this title",
              snippet: "snipset",
            ));
    markers.add(marker);
    setState(() {

    });

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addmarker("id", ["asstes/icon1.png","asstes/icon2.png"], LatLng(37.42796133580664,  -122.08832357078792));
    addmarker("id2", ["asstes/img03.png","asstes/img03.png"], LatLng(37.45796133580664,  -122.03832357078792));
    addmarker("id3", ["asstes/img03.png","asstes/icon1.png"], LatLng(37.45196133580664,  -122.13832357078792));


  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers:markers,
//        {
//          Marker(
//
//            position: LatLng(37.42796133580664,  -122.08832357078792),
//            markerId: MarkerId("id"),
//
//            icon: icon2,
//            infoWindow: InfoWindow(
//             title:  "this title",
//              snippet: "snipsa",
//
//
//            )
//
//          ),
//          Marker(
//
//              position: LatLng(37.42796133580684,  -122.18832357078799),
//              markerId: MarkerId("id2"),
//
//              icon: icon,
//              infoWindow: InfoWindow(
//                title:  "this title",
//                snippet: "sniasdpsa",
//
//
//              )
//
//          ),
//        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }



  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

  }
}