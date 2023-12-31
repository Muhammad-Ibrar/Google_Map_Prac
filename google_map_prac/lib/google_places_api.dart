import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({Key? key}) : super(key: key);

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {

  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '12345';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {

      onChanged();
    });
  }

  void onChanged(){

    if(_sessionToken == null){
      setState(() {
        _sessionToken = uuid.v4();

      });
    }

    getSuggestion(_controller.text);

    }
    void getSuggestion(String input) async{

    String kPLACES_API_KEY = "AIzaSyAiTKXFz-j6mq3h7wlWnYRPR7VaW7XNATs";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    print('data');
    print(data);

    if(response.statusCode == 200){
      setState(() {
        _placesList = jsonDecode(response.body.toString()) ['predications'];
      });
    }
    else {
      throw Exception('Failed to load');
    }

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Google Search Api '),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            TextFormField(
              decoration:const InputDecoration(
                hintText: 'Search Places With Name'
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: _placesList.length,
                    itemBuilder: (context , index){
                    return ListTile(
                      onTap: () async {
                        List<Location> locations = await locationFromAddress(_placesList[index]['description']);
                        print(locations.last.latitude);
                        print(locations.last.longitude);
                      },
                      title: Text(_placesList[index]['description']),
                    );
                    })
            )
          ],
        ),
      ),
    );
  }
}
