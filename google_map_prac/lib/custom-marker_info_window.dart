import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];

  final List<LatLng> _latlng = <LatLng> [
    LatLng(33.6941 , 72.9546), LatLng(33.7008 , 72.9682) , LatLng(33.6992 , 72.9744),
    LatLng(33.6939 , 72.9771) , LatLng(33.6910 , 72.9807)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {

    for (int i = 0 ; i< _latlng.length ; i++) {
      if(i % 2 == 0 ){
        _markers.add(Marker(markerId:MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker ,
            position: _latlng[i],
            onTap: (){
              _customInfoWindowController.addInfoWindow!(
                  Container(
                    height: 300,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Center(
                      child: CircleAvatar(radius: 30, backgroundColor: Colors.blue,),
                    )
                  ),
                  _latlng[i]

              );
            }
        )
        );
      }
      else {
        _markers.add(Marker(markerId:MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker ,
            position: _latlng[i],
            onTap: (){
              _customInfoWindowController.addInfoWindow!(
                  Container(
                    height: 300,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 100,
                          decoration:const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://images.pexels.com/photos/7904958/pexels-photo-7904958.jpeg?auto=compress&cs=tinysrgb&w=600'),
                                fit: BoxFit.fitWidth,
                                filterQuality: FilterQuality.high,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: Colors.red


                          ),
                        ),
                       const Padding(
                            padding: EdgeInsets.only(top: 10 , right: 10 , left: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'Beef Tacos',
                                ),
                              )
                            ],
                          ),
                        ),
                       const Padding(
                            padding: EdgeInsets.only(top: 10 , right: 10, left: 10),
                          child: Text('This Tacos are very decilious and i suggest you to try this.' , maxLines: 2,),

                        ),
                      ],
                    ),
                  ),
                  _latlng[i]

              );
            }
        )
        );
      }

      setState(() {

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Custom Marker Info Window'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(33.6941 , 72.9546),
                zoom: 15,

              ),
            markers: Set<Marker>.of(_markers),
            onTap: (position){
                _customInfoWindowController.hideInfoWindow!();
            },
              onCameraMove: (position){
                _customInfoWindowController.onCameraMove!();
              },
            onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
            }
          ),
          CustomInfoWindow(
              controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 40,
          )
        ],
      ),
    );
  }
}
