import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {

  List<String> images = ['images/car.png' , 'images/motorcycle.png' , 'images/marker.png' ,
                         'images/location-pin.png' , 'images/location.png'];

  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;
  final List<Marker> _markers = <Marker>[];

  final List<LatLng> _latlng = <LatLng> [
    LatLng(33.6941 , 72.9546), LatLng(33.7008 , 72.9682) , LatLng(33.6992 , 72.9744),
    LatLng(33.6939 , 72.9771) , LatLng(33.6910 , 72.9807)
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
      target:LatLng(33.6910, 72.98072) ,
    zoom: 15
  );

  Future<Uint8List> getBytesFromAssets(String path , int width)async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List() , targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()async{
    for(int i=0;  i< images.length ; i++){

      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);

      _markers.add(
        Marker(markerId: MarkerId(i.toString()),
         position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: 'This is title: '+i.toString()
          )
        )
      );
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Custom Marker Screen'),
        centerTitle: true,
      ),
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
        },
      ),
    );
  }
}
