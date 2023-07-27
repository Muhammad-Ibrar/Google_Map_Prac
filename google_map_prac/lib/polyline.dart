import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({Key? key}) : super(key: key);

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33.738045 , 73.884488) ,
    zoom: 10
  );
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> _latlng = [
    LatLng(33.738045 , 73.884488),
    LatLng(33.567997728 , 73.636997456),
    LatLng(33.647326 , 72.820175),
    LatLng(33.689531 , 72.763160),
    LatLng(33.131452 , 72.662334),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i =0; i<_latlng.length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
          position: _latlng[i],
          infoWindow:const InfoWindow(
              title: 'Cool Place',
            snippet: '5 star Rating'
          ),
          icon: BitmapDescriptor.defaultMarker
        )
      );
      setState(() {

      });
      _polyline.add(
          Polyline(polylineId: PolylineId('1'),
              points: _latlng,
            color: Colors.orange
          )
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('PolyLine Screen'),
        centerTitle: true,
      ),
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
        },
        polylines: _polyline,
        myLocationButtonEnabled: true,
        markers: _markers,
        mapType: MapType.normal,
      ),

    );
  }
}
