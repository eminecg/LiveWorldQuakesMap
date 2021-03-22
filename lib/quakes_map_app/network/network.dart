
import 'dart:convert';
import 'package:http/http.dart';
import 'package:world_quakes/quakes_map_app/model/quake.dart';


class Network{

  Future <Quake> getAllQuakes() async{
    var apiUrl="https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson";
    final response =await get(Uri.encodeFull(apiUrl)); // import http package

    if(response.statusCode==200){
      print("Quake data : ${response.body}");
      return Quake.fromJson(json.decode(response.body)); // import dart convert package
    }
    else{
      throw Exception("Error getting quakes");
    }

  }

}