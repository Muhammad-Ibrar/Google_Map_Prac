import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyGoneScreen extends StatefulWidget {
  const PolyGoneScreen({Key? key}) : super(key: key);

  @override
  State<PolyGoneScreen> createState() => _PolyGoneScreenState();
}

class _PolyGoneScreenState extends State<PolyGoneScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33.654235 , 73.073000) ,
    zoom: 14,

  );

  Set<Polygon> _polygone = HashSet<Polygon>();

  List<LatLng> points = [
    LatLng(33.654235 , 73.073000),
    LatLng(33.647326 , 72.820175),
    LatLng(33.689531 , 72.763160),
    LatLng(33.131452 , 72.662334),
    LatLng(33.654235 , 73.073000),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _polygone.add(
      Polygon(polygonId: PolygonId('1') , points: points,
        fillColor: Colors.red.withOpacity(0.3),
        strokeWidth: 4,
          strokeColor: Colors.deepOrange,
        geodesic: true
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('PolyGone Screen'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        polygons: _polygone,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
