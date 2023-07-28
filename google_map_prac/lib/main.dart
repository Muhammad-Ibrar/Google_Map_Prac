import 'package:flutter/material.dart';
import 'package:google_map_prac/convert_latlan_to_address.dart';
import 'package:google_map_prac/custom-marker_info_window.dart';
import 'package:google_map_prac/custome_marker_screen.dart';
import 'package:google_map_prac/google_places_api.dart';
import 'package:google_map_prac/home_screen.dart';
import 'package:google_map_prac/network_image_marker.dart';
import 'package:google_map_prac/polygone_screen.dart';
import 'package:google_map_prac/polyline.dart';
import 'package:google_map_prac/style_googlemap.dart';
import 'package:google_map_prac/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home:const GoogleMapStyling(),
    );
  }
}
