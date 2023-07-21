import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex =CameraPosition(
      target:LatLng(33.86338870354975, 71.56588407172485),
    zoom: 14.4746,

  );

  List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
        markerId: MarkerId('1'),
      infoWindow: InfoWindow(
        title: 'My Location'
      ),
      position: LatLng(33.86338870354975, 71.56588407172485),

    ),
    const Marker(
      markerId: MarkerId('2'),
      infoWindow: InfoWindow(
          title: 'Marker 2'
      ),
      position: LatLng(32.86338870354975, 71.56588407172485),

    )
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.location_disabled_outlined),
        onPressed: ()async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
           const CameraPosition(
                target: LatLng(32.86338870354975, 71.56588407172485),
              zoom: 14
            )
          ));
        },
      ),
    );
  }
}
