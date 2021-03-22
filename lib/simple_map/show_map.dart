import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ShowSimpleMap extends StatefulWidget {
  @override
  _ShowSimpleMapState createState() => _ShowSimpleMapState();
}

class _ShowSimpleMapState extends State<ShowSimpleMap> {
  // we need google map controller
  GoogleMapController mapController;
  // contain Lat and long of a certain place that we can see tha this is actually working
  //latitude and longitude --> enlem ve boylam
  static  LatLng _center=const LatLng(41.015137, 28.979530);
  static LatLng _anotherLocation=const LatLng(39.925533,32.866287);

  void _onMapCreated (GoogleMapController controller){
    mapController=controller;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar:AppBar(
        title:Text("Maps"),
      ),
      body :GoogleMap(
        // markers expects a set so
        markers:{IstMarker,DnzlMarker},

        mapType:MapType.normal,
        //pass controller
        onMapCreated: _onMapCreated ,
        //target  that location to the pass and show the app
        initialCameraPosition:CameraPosition(target: _center,zoom:11) ,
      ),

      floatingActionButton: FloatingActionButton.extended(onPressed:_goToIntel,label:Text("Intel Coorp"),icon:Icon(Icons.place),),


    );
  }
  static final CameraPosition intelPosition =CameraPosition(
    target: LatLng(45.5409806,-122.9181941),
    zoom:14.780,
    bearing :191.789,
    tilt:35.89,

  );
  // floating action button onPPressed function
  Future<void> _goToIntel () async{
final GoogleMapController controller =await mapController;
  controller.animateCamera(CameraUpdate.newCameraPosition(intelPosition));


  }
  Marker IstMarker=Marker(
    markerId:MarkerId("Istanbul/TURKEY"),
    position:_center,
    infoWindow:InfoWindow(title:"Turkey",),
    icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed,),


  );
  Marker DnzlMarker=Marker(
    markerId:MarkerId("Denizli/TURKEY"),
    position:_anotherLocation,
    infoWindow:InfoWindow(title:"Turkey",),
    icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue,),

  );

}

