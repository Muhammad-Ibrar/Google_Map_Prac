import 'package:flutter/material.dart';
import 'package:google_map_prac/convert_latlan_to_address.dart';
import 'package:google_map_prac/home_screen.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const GetUserCurrentLocation(),
    );
  }
}
