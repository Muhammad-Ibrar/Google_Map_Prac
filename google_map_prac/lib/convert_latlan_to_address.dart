import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class LatLanToAddress extends StatefulWidget {
  const LatLanToAddress({Key? key}) : super(key: key);

  @override
  State<LatLanToAddress> createState() => _LatLanToAddressState();
}

class _LatLanToAddressState extends State<LatLanToAddress> {
  String stAddress = '' , stad = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const Text('Google Map'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(stAddress),
           GestureDetector(
             onTap: ()async{
               List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");

               List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);

               setState(() {
                 stAddress = locations.last.latitude.toString()+ " " + locations.last.longitude.toString();
                 stad = placemarks.reversed.toString() + " " + placemarks.reversed.toString();
               });

             },
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green
                  ),
                  child:const Center(
                    child: Text('Convert'),
                  ),
                ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
