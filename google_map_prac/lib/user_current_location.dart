import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33.6844, 73.0479),
    zoom: 14
  );

  final List<Marker> _markers  =<Marker> [
    Marker(
        markerId: MarkerId('1'),
      position: LatLng(33.6844, 73.0479 ),
      infoWindow: InfoWindow(
        title: 'The title of the marker'
      )

    ),
  ];

  loadData(){
    getUserCurrentLocation().then((value) async {
      print('My Current Location');
      print(value.longitude.toString()+ " " + value.latitude.toString());

      _markers.add(
          Marker(
              markerId: MarkerId('2'),
              position: LatLng(value.longitude , value.latitude),
              infoWindow: InfoWindow(
                  title: 'My Current Location'
              )
          )
      );

      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.longitude , value.latitude),
          zoom: 14
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {

      });

    });
  }

  Future<Position> getUserCurrentLocation () async {
     await Geolocator.requestPermission().then((value){

     }).onError((error, stackTrace){
       print('error '+error.toString());
     });

     return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print('My Current Location');
            print(value.longitude.toString()+ " " + value.latitude.toString());

            _markers.add(
              Marker(
                  markerId: MarkerId('2'),
                position: LatLng(value.longitude , value.latitude),
                infoWindow: InfoWindow(
                  title: 'My Current Location'
                )
              )
            );

            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.longitude , value.latitude),
              zoom: 14
            );

            final GoogleMapController controller = await _controller.future;

            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {

            });

          });
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}
