import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapStyling extends StatefulWidget {
  const GoogleMapStyling({Key? key}) : super(key: key);

  @override
  State<GoogleMapStyling> createState() => _GoogleMapStylingState();
}

class _GoogleMapStylingState extends State<GoogleMapStyling> {

  String mapTheme = '';
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33.6941 , 72.9734),
      zoom: 13
  );
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/maptheme/silver_theme.json').then((value){
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Google Map Theme'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
              PopupMenuItem(
                 onTap: (){
                   _controller.future.then((value){
                     DefaultAssetBundle.of(context).loadString('assets/maptheme/night_theme.json').then((string){
                       value.setMapStyle(string);
                     });
                   });
                 },
                    child: Text('Night'),
                ),
               PopupMenuItem(
                 onTap: (){
                   _controller.future.then((value){
                     DefaultAssetBundle.of(context).loadString('assets/maptheme/silver_theme.json').then((string){
                       value.setMapStyle(string);
                     });
                   });
                 },
                  child: Text('Silver'),
                ),
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value){
                      DefaultAssetBundle.of(context).loadString('assets/maptheme/retro_theme.json').then((string){
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: Text('Retro'),
                )
              ]
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
        },
      ),
    );
  }
}
