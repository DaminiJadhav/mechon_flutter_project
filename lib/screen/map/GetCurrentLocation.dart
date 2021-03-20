import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocation extends StatefulWidget {
  @override
  _GetCurrentLocationState createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  double  latitudeData;
  double  longitude;
  String addre1,addre2;

  @override
  void initState() {

  }


  getCurrentLocation() async{
    print("location");

    try {
      // Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
      //
      // Position position = await geolocator.getCurrentPosition(
      //   desiredAccuracy: LocationAccuracy.low,
      // );
      Position position = await Geolocator.getLastKnownPosition();

      if(position!=null){
        print('location success');
        setState(() {
          latitudeData=position.latitude;
          longitude=position.longitude;
          if(latitudeData!=null && longitude!=null){
            // getAddressbaseloacation();
            print(latitudeData.toString()+","+longitude.toString());
          }
         // print(latitudeData longitude);
        });
      }

      return position;
    } catch (err) {
      print("error :"+err.message);
    }

  }

  // getAddressbaseloacation() async{
  //   final coordinates=new Coordinates(latitudeData,longitude);
  //   var address=await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   setState(() {
  //     addre1=address.first.featureName;
  //     addre2=address.first.addressLine;
  //   });
  //
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current location'),
      ),
      body: Column(
        children: <Widget>[
          if(addre1!=null) Text("${addre1}"),
          if(addre2!=null) Text("${addre2}"),
          RaisedButton(
            onPressed: (){
              print('click');
              getCurrentLocation();
            },
            child: Text("get location"),
          )

        ],
      ),
    );
  }
}