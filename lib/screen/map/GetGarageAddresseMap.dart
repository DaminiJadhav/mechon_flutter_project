import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mechon/utility/Utility.dart';
import 'package:mechon/utility/Utility.dart';

// latLng=LatLng(18.5652198,73.7689985);
// lat-18.5652198
// long-73.7689985

const googleApiKey="AIzaSyC_frIldpyoysQZE1pqGVIfBS9_9n1m4zM";
// const googleApiKey="AIzaSyBA_cL491_5XehTSRVCDRtnxdvOHyinH6E";


GoogleMapsPlaces _places=GoogleMapsPlaces(apiKey: googleApiKey);


class GetGarageAddressMap extends StatefulWidget {
  @override
  _GetGarageAddressMapState createState() => _GetGarageAddressMapState();
}

class _GetGarageAddressMapState extends State<GetGarageAddressMap> {
  double latitude;
  double longitute;
  static LatLng latLng;
  String currentAddress;
  final Set<Marker> _marker={};

  final searchErrorScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchController=new TextEditingController();

  @override
  void initState() {
   // getLocation();

    setState(() {
      getCurrentLocation();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechon'),
      ),
      body: selectGarageLocation(),

    );
  }




  Widget selectGarageLocation(){
    
    return  Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          color: MyColors.white,
          padding: EdgeInsets.only(left: 15),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(fontSize: 20),
              border: InputBorder.none,
              icon: Icon(Icons.search),
            ),
            onTap: (){
              _searchLocation(context);
            },
          ),

        ),
        latLng!=null ? Expanded(
          child: Stack(
            children: [
              GoogleMap(
                markers: _marker,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: latLng,
                  zoom: 14.4748
                ),
                myLocationEnabled: true,
                onTap: (latlng){
                  print('${latlng.latitude}, ${latlng.longitude}');
                  latitude=latlng.latitude;
                  longitute=latlng.longitude;
                  getAddressbaseloacation();
                  _marker.clear();
                  addMakerButton(latlng);
                },
             ),
             if(currentAddress!=null) Align(
               alignment: Alignment.bottomCenter,
               child: Wrap(
                 children: [
                 Container(
                   margin: EdgeInsets.all(20),
                   // height: 120,
                   child: Card(
                     // margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15.0),
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left:15.0,right: 10,top: 10),
                           child: Text(currentAddress),
                         ),
                         GestureDetector(
                           onTap: (){
                             if(currentAddress!=null){
                               Navigator.of(context).pop({"GARAGEADDRESS": currentAddress,
                                 "LATITUDE" : latitude.toString(),
                                 "LONGITUTE": longitute.toString()});
                             }
                           },
                           child: Container(
                             margin: EdgeInsets.only(top: 10,bottom: 10),
                             padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
                             child: Text('Confirm',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(15)),
                               color: Colors.red
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
                 ],
               )
             ),


            ],
          ),
        ): Center(child: CircularProgressIndicator(backgroundColor: Colors.red,))
      ],
    );
  }

  void addMakerButton(LatLng latlong){
    setState(() {
      _marker.add(
          Marker(
              markerId: MarkerId("111"),
              position: latlong,
              icon: BitmapDescriptor.defaultMarker,

          )
      );
    });
  }


  getCurrentLocation() async{
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
          latitude=position.latitude;
          longitute=position.longitude;
          if(latitude!=null && longitute!=null){
            getAddressbaseloacation();
            setState(() {
              latLng=LatLng(latitude,longitute);
              if(latLng!=null){
                addMakerButton(latLng);
              }
            });
            print(latitude.toString()+","+longitute.toString());
          }
        });
      }

      return position;
    } catch (err) {
      print("error :"+err.message);
    }

  }

    getAddressbaseloacation() async{
      final coordinates=new Coordinates(latitude,longitute);
      var address=await Geocoder.local.findAddressesFromCoordinates(coordinates);
      setState(() {
        currentAddress=address.first.addressLine;
        print("Address :"+currentAddress);
      });
    }

    Future<void> _searchLocation(BuildContext context) async{
      Prediction prediction=await PlacesAutocomplete.show(
          context: context,
          apiKey:googleApiKey,
          onError: onError,
          mode: Mode.overlay,
          language: "en",
          components: [Component(Component.country,"IN")]

      );
      _displaySelectedLocation(prediction);
    }

    Future<Null> _displaySelectedLocation(Prediction  p) async{
      if(p!=null){
        PlacesDetailsResponse response=await _places.getDetailsByPlaceId(p.placeId);
        setState(() {
          latitude=response.result.geometry.location.lat;
          longitute=response.result.geometry.location.lng;
        });


        // searchScaffoldKey.currentState.showSnackBar(
        //   SnackBar(content: Text("${p.description}-$lat/$log"),)
        // );

        setState(() {
          currentAddress=p.description;
          searchController.text=p.description;
          print(currentAddress);

        });

        latLng=LatLng(latitude,longitute);

        Utility.instance.hideKeyboard(context);


        _marker.clear();
        addMakerButton(latLng);

      }
    }

    void onError(PlacesAutocompleteResponse response){
        searchErrorScaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text(response.errorMessage))
        );
    }







  /*getLocation() async{
    var location=new Location();
    location.onLocationChanged.listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);


      longitute=currentLocation.longitude;
      latitude=currentLocation.latitude;

      setState(() {
         latLng=LatLng(currentLocation.latitude,currentLocation.longitude);
      });

      print("GetLocation ${latLng}");
    });


  }*/
}
