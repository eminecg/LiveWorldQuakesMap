import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/quake.dart';
import 'network/network.dart';

class QuakesApp extends StatefulWidget {
  @override
  _QuakesAppState createState() => _QuakesAppState();
}

class _QuakesAppState extends State<QuakesApp> {
  Future <Quake> _quakesData;

  //Completer a way to produce a future object and to complete them at a later with either value or an error
  //If you do need to create a Future from scratch — for example,
  // when you're converting a callback-based API into a Future-based one — you can use a Completer as follows:
  Completer <GoogleMapController> _controller = Completer(); //import async package and google map package
  //marker list
  List <Marker> _markerList = <Marker>[];

  double _zoomVal = 5.0; // zoom value control zooming


  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    _quakesData = Network().getAllQuakes();
    // using then
    //_quakesData.then((values)=>{
    //   print ("Place: ${values.features[0].geometry.coordinates[0]}"),});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The reason why we passing the stack is because I want to be able to stack things onthe top of our map
      body: Stack(
          children: <Widget>[
            _buildGoogleMap(context),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: _zoomMinus(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8.0,left:4),
                    child: _zoomPlus(),
                  ),
                ],
              ),
            ),



          ]

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: findQuakes,
        label: Text("Find Quakes"),

      ),


    );
  }

//
  Widget _zoomMinus() {
// Aline widget
   return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          _zoomVal--;
          _minus(_zoomVal);
        },
        icon: Icon(FontAwesomeIcons.searchMinus, color: Colors.black87),

      ),
    );
  }
  Widget _zoomPlus() {
// Aline widget
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          _zoomVal++;
          _plus(_zoomVal);
        },
        icon: Icon(FontAwesomeIcons.searchPlus, color: Colors.black87),

      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(36.1083333, -177.8608333), zoom: 3),
        markers: Set<Marker>.of(_markerList),
      ),

    );
  }

// we need markers these holds earth quakes location info
  void findQuakes() {
    setState(() {
      _markerList.clear(); //clear the map the beginning
      _handleResponse(); // marker ları map e ekleme yapıcak


    });
  }


  void _handleResponse() {
    setState(() {
      _quakesData.then((quakes) =>
      {
        // element yerine listedeki element type nı gir
        quakes.features.forEach((quake) =>
        {
          _markerList.add(Marker(markerId: MarkerId(quake.id),
              infoWindow: InfoWindow(
                title: quake.properties.mag.toString(),
                snippet: quake.properties.title,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueMagenta),
              //most important component position of the marker,get the coordinates and fetch them
              // 3 components from apı and their turn longitude and then latitude
              position: LatLng(
                quake.geometry.coordinates[1], quake.geometry.coordinates[0],),
              onTap: () {

              }
          ),),

        })
      });
    });
  }


  Future <void> _minus(double zoomVal) async {
    // o anki control objesi üzerinden hareket etmek için sanırım onu cekiyoruz 
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(40.712776, -74.005974),zoom: _zoomVal),
    ));
  }
  Future <void> _plus(double zoomVal) async {
    // o anki control objesi üzerinden hareket etmek için sanırım onu cekiyoruz
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(40.712776, -74.005974),zoom: _zoomVal),
    ));
  }

}