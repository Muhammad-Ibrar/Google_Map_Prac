import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({Key? key}) : super(key: key);

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33.6941 , 72.9734),
    zoom: 13
  );

  final List<Marker> _markers = <Marker>[];

  List<LatLng> _latlng = [
    LatLng(33.6941 , 72.9734),
    LatLng(33.7008 , 72.9682),
    LatLng(33.6992 , 72.9744)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i=0; i<_latlng.length;i++){
      Uint8List? image = await loadNetWorkImage('https://images.pexels.com/photos/974266/pexels-photo-974266.jpeg?auto=compress&cs=tinysrgb&w=600');

      final ui.Codec markerImageCodec = await  ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetWidth: 200,
        targetHeight: 200
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await  frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png
      );

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
          position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          infoWindow: InfoWindow(
            title: 'This is marker no: '+i.toString()
          )

        )
      );
      setState(() {

      });
    }
  }

 Future<Uint8List?> loadNetWorkImage(String path) async {

    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((Info,_) =>completer.complete(Info))
    );

    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format:ui.ImageByteFormat.png );

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Network Image Marker'),
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
