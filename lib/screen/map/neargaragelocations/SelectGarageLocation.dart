import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/firebase/PushNotificationsManager.dart';
import 'package:mechon/model/notification/Message.dart';
import 'package:mechon/model/response/GetNearByGarageLocationResponse.dart';
import 'package:mechon/screen/home/user/UserHomeScreen.dart';
import 'package:mechon/screen/login/LoginScreen.dart';
import 'package:mechon/screen/map/neargaragelocations/controller/NearByGarageLocationContract.dart';
import 'package:mechon/screen/map/neargaragelocations/presenter/NearByGarageLocationPresenter.dart';
import 'package:mechon/screen/vehicleIssue/VehicleIssueScreen.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class SelectGarageLocation extends StatefulWidget {
  int vehicleTypeId;
  SelectGarageLocation({this.vehicleTypeId});

  @override
  _SelectGarageLocationState createState() => _SelectGarageLocationState();
}

class _SelectGarageLocationState extends State<SelectGarageLocation> implements NearByGarageLocationContract{
  int vehicleId;
  double latitude;
  double longitute;
  String currentAddress;

  bool _isVisibleFloatingButton=true;
  static final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
  static  List<Message> messages=[];

  final Set<Marker> _marker={};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  static LatLng latLng,latLng1;
  BitmapDescriptor pinLocationIcon;
  Completer<GoogleMapController> _controller=Completer();
  bool _isloading = false;
  bool isBackButton=true;
  bool isTooltipShow=false;


  String notificationTitle,notificationBody;


  var icon;
  bool requestAccept=true;

  NearByGarageLocationPresenter nearByGarageLocationPresenter;

  _SelectGarageLocationState(){
    nearByGarageLocationPresenter=new NearByGarageLocationPresenter(this);
  }


  @override
  void initState() {
    super.initState();
    sendNotification();
    // PushNotificationsManager.sendNotification();

    vehicleId=widget.vehicleTypeId;
    if(vehicleId!=null){
      print("Vehicle id");
    }else{
      print("Vehicle null");

    }
    // toast().showToast(vehicleId.toString());
    // latLng=LatLng(18.5652198,73.7689985);
    getCurrentLocation();

    setState(() {
      _isloading=true;
    });

    // latLng1=LatLng(18.4852198,73.7989985);
    // addMakerButton(latLng);

    // addMakerButton(latLng1);

  }


  @override
  void dispose() {
    print('screen close');
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      // appBar: CurveAppBar.getAppbar("Lo  cation", context),
      body: LoadingOverlay(
        isLoading:_isloading ,
        opacity: 0.5,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: MyColors.red,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
        child: Stack(
            children: [
              if(latLng!=null) GoogleMap(
                markers: Set<Marker>.of(markers.values),
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: latLng,
                    zoom: 14.4748
                ),
              ),
              Visibility(
                visible: isTooltipShow,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 60,right: 60),
                    child: SimpleTooltip(
                        maxWidth: 250,
                        maxHeight: 100,
                        backgroundColor: MyColors.grey[350],
                        borderColor: Colors.black,
                        tooltipDirection: TooltipDirection.left,
                        content: Container(
                            child: Text("Hey, Are you new User?/Do you have any vehicle issue? ",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),)
                        ),
                        show: true,
                        tooltipTap: (){
                        },
                        animationDuration: Duration(seconds: 2),
                    ),
                  ),
                ),
              ),
               // Container(
               //   child: RaisedButton(
               //     child: Text("ok"),
               //     onPressed: (){
               //       setState(() {
               //         isTooltipShow=false;
               //       });
               //       _showAcceptedRequest();
               //     },
               //   ),
               // )

               // if(!_isVisibleFloatingButton) Align(
               //    alignment: Alignment.bottomCenter,
               //    child: Wrap(
               //      children: [
               //     Container(
               //        // height: 100,
               //        width: MediaQuery.of(context).size.width,
               //        margin: EdgeInsets.all(20),
               //        child: Card(
               //            color: MyColors.white,
               //            shape: RoundedRectangleBorder(
               //              borderRadius: BorderRadius.circular(15.0),
               //            ),
               //            child: Column(
               //              children: [
               //                Row(
               //                      // mainAxisAlignment: MainAxisAlignment.start,
               //                      // crossAxisAlignment: CrossAxisAlignment.start,
               //                      children: [
               //                        Expanded(
               //                          flex: 2,
               //                          child: Column(
               //                            children: [
               //                              Container(
               //                                  padding: EdgeInsets.only(left: 15,top: 8),
               //                                  alignment:Alignment.centerLeft,
               //                                  child: Text(notificationTitle)
               //
               //                                // child: Text("Garage Name")
               //                              ),
               //                              Container(
               //                                  padding: EdgeInsets.only(left: 15),
               //                                  alignment:Alignment.centerLeft,
               //                                  child: Text(notificationBody)
               //                                // child: Text("Garage Address")
               //                              ),
               //                              Container(
               //                                  padding: EdgeInsets.only(left: 15),
               //                                  alignment:Alignment.centerLeft,
               //                                  child: Text("Owner name")
               //                              ),
               //                              Container(
               //                                  padding: EdgeInsets.only(left: 15,bottom: 10),
               //                                  alignment:Alignment.centerLeft,
               //                                  child: Text("Mobile number")
               //                              ),
               //                            ],
               //                          ),
               //                        ),
               //                        Expanded(
               //                          flex: 1,
               //                          child:GestureDetector(
               //                            onTap: (){
               //                              FlutterPhoneDirectCaller.callNumber("9657431432");
               //                            },
               //                            child: Container(
               //                              child: Icon(Icons.call),
               //                            ),
               //                          )
               //                        )
               //                      ],
               //                  ),
               //                GestureDetector(
               //                  onTap: (){
               //                    _navigateLocationDirection(18.706655,74.106762);
               //
               //                  },
               //                  child: Container(
               //                    // alignment:Alignment.center,
               //                    padding: EdgeInsets.only(top: 8,left: 10,right: 10,bottom: 8),
               //                    margin: EdgeInsets.only(bottom: 8),
               //                    decoration: BoxDecoration(
               //                        color: MyColors.red,
               //                        borderRadius: BorderRadius.all(Radius.circular(10))
               //                    ),
               //                    child: Text('Direction',style: TextStyle(color: MyColors.white,fontWeight: FontWeight.bold),),
               //                  ),
               //                )
               //              ],
               //            )
               //        ),
               //      ),
               //     ]
               //    ),
               //  )
            ]
        ),
      ),

      floatingActionButton: Visibility(
        visible: _isVisibleFloatingButton,
        child: FloatingActionButton(
          backgroundColor: MyColors.red,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: (){
            if(SessionManager.getUserId()!=null){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => VehicleIssueScreen()));
            }else{
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()));

            }
          },
        ),
      ),

    );
  }


  void addMakerButton(LatLng latlong){

    setState(() {


      _marker.add(
          Marker(
            markerId: MarkerId("111"),
            position: latlong,
            // icon: BitmapDescriptor.fromAsset("assets/car_icon.png",),
            infoWindow: InfoWindow(
                title: "Sdaemon Infotech",
                snippet: "Aundh"
            ),

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

            nearByGarageLocationPresenter.getNearByGarageLocationList(vehicleId,latitude, longitute);

            // latLng1=LatLng(18.4852198,73.7989985);
            // addMakerButton(latLng1);
            // latLng=LatLng(18.5652198,73.7689985);
            //
            // addMakerButton(latLng);
            setState(() {
              latLng=LatLng(latitude,longitute);
              // if(latLng!=null){
              //   addMakerButton(latLng);
              // }
            });
            print("Lat :"+latitude.toString()+" Log :,"+longitute.toString());
          }
        });
      }

      return position;
    } catch (err) {
      print("error :"+err.message);
    }

  }





  // _phoneCall() async{
  //   const url='tel:9657431432';
  //   if(await canLaunch(url)){
  //     await launch(url);
  //   }else{
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  void getNearByGarageLocationSError(String message) {
    setState(() {
      _isloading=false;
      isBackButton=false;
      isTooltipShow=false;
    });
    // toast().showToast("Something Went Wrong");
    _notNearByGarageDialog();


  }


  @override
  void getNearByGarageLocationSucess(GetNearByGarageLocationResponse garageLocationResponse) {
    // toast().showToast(garageLocationResponse.message);
    setState(() {
      _isloading=false;
      isTooltipShow=true;

    });
    if(garageLocationResponse.status==1){
      generateMarkers(garageLocationResponse.userGarageIssueRequest);
    }else{
      // _notNearByGarageDialog();

    }


  }




  Future<Set<Marker>> generateMarkers(List<UserGarageIssueRequest> positions) async {
    for (final location in positions) {
      var markerIdVal=generateIds();
      final MarkerId markerId = MarkerId(markerIdVal.toString());

      final icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(24, 24)), 'assets/garage_icon.png');

      final marker = Marker(
        markerId: markerId,
        // markerId: MarkerId(location.toString()),
        position: LatLng(location.garageLatitude, location.garageLongitude),
        icon: BitmapDescriptor.defaultMarker,
        // icon: icon,

        infoWindow: InfoWindow(
            title: location.garageOwnerName,
            snippet: location.garageName
        ),
      );
      markers[markerId]=marker;

      // _marker.add(marker);
    }


    return _marker.toSet();

  }

  int generateIds() {
    var rng = new Random();
    var randomInt;
    randomInt = rng.nextInt(100);
    print(rng.nextInt(100));
    return randomInt;
  }




  _notNearByGarageDialog(){
    return showDialog(
        barrierDismissible: false,
        useRootNavigator: false,

        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Wrap(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text("You don't have any near by"),
                      Text("garages"),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.pop(context);

                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => UserHomeScreen()));


                          // Navigator.of(context).popUntil(ModalRoute.withName('/HomeScreen'));
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                          margin: EdgeInsets.only(top: 20),
                          child: Text('OK',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Colors.red
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  void setCustomMapPin() async{
    // icon = await BitmapDescriptor.fromAssetImage(
    //    ImageConfiguration(size: Size(24, 24)), 'assets/car.jpg');

    pinLocationIcon=await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/car.jpg",
    );

  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }



  Future<void> sendNotification()  {
    _firebaseMessaging.configure(
        onMessage: (Map<String,dynamic> message) async{

          setState(() {
            _isVisibleFloatingButton=false;
            print("onMessage ******: $message");

            final notification=message['notification'];
            notificationTitle=notification['title'];
            notificationBody=notification['body'];
            setState(() {
              isTooltipShow=false;
            });
            // toast().showToast(notificationTitle);
            _showAcceptedRequest();
            messages.add(Message(title: notification['title'],body:notification['body']));
          });

        },
        onLaunch: (Map<String,dynamic> message) async{
          print("onLaunch *******: $message");

        },
        onResume: (Map<String,dynamic> message) async{
          print("onResume ********: $message");

        }
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true,badge: true,alert: true,provisional: false)
    );

    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print('Setting Registered : $settings');
    });

  }






  _navigateLocationDirection(double lat,double lng) async{
    // if(Platform.isAndroid){
    //   var uri=Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    //   if(await canLaunch(uri.toString())){
    //     await launch(uri.toString());
    //   }else{
    //     throw 'Could not launch ${uri.toString()}';
    //   }
    // }else{
    //  print("IOS");
    // }

  }




  void _showAcceptedRequest() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            StatefulBuilder(builder: (BuildContext context, StateSetter setState
                /*You can rename this!*/) {
              return Align(
                     alignment: Alignment.bottomCenter,
                     child: Wrap(
                       children: [
                      Container(
                         // height: 100,
                         width: MediaQuery.of(context).size.width,
                         margin: EdgeInsets.all(20),
                         child: Column(
                               children: [
                                 Row(
                                       children: [
                                         Expanded(
                                           flex: 2,
                                           child: Column(
                                             children: [
                                               Container(
                                                   padding: EdgeInsets.only(left: 15,top: 8),
                                                   alignment:Alignment.centerLeft,
                                                   child: Text("Garage Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)

                                                 // child: Text("Garage Name")
                                               ),
                                               Container(
                                                   padding: EdgeInsets.only(left: 15),
                                                   alignment:Alignment.centerLeft,
                                                   child: Text("Garage location")
                                                 // child: Text("Garage Address")
                                               ),
                                               Container(
                                                   padding: EdgeInsets.only(left: 15),
                                                   alignment:Alignment.centerLeft,
                                                   child: Text("Owner name")
                                               ),
                                               Container(
                                                   padding: EdgeInsets.only(left: 15,bottom: 10),
                                                   alignment:Alignment.centerLeft,
                                                   child: Text("Mobile number")
                                               ),
                                             ],
                                           ),
                                         ),
                                         Expanded(
                                           flex: 1,
                                           child:GestureDetector(
                                             onTap: (){
                                               FlutterPhoneDirectCaller.callNumber("9657431432");
                                             },
                                             child: Container(
                                               child: Icon(Icons.call,size: 28,),
                                             ),
                                           )
                                         )
                                       ],
                                   ),
                                 Padding(
                                   padding: const EdgeInsets.only(top:10.0),
                                   child: Row(
                                       children: [
                                         Expanded(
                                           child: GestureDetector(

                                             child: Container(
                                               alignment:Alignment.center,
                                               padding: EdgeInsets.only(top: 10,bottom: 10),
                                               margin: EdgeInsets.only(right: 10),
                                               // color: MyColors.red,
                                               decoration: BoxDecoration(
                                                   // color: MyColors.red,
                                                   border: Border.all(width: 1,color: MyColors.red),
                                                   // borderRadius: BorderRadius.all(Radius.circular(10))
                                               ),
                                               child: Text('Cancel',style: TextStyle(color: MyColors.red,fontWeight: FontWeight.bold,),),
                                             ),
                                             onTap: (){
                                               Navigator.pop(context);
                                             },
                                           ),
                                         ),
                                         Expanded(
                                             child: GestureDetector(
                                               child: Container(
                                                 color: MyColors.red,
                                                 alignment:Alignment.center,
                                                 padding: EdgeInsets.only(top: 10,bottom: 10),
                                                 // margin: EdgeInsets.only(bottom: 8),
                                                 // decoration: BoxDecoration(
                                                 //     color: MyColors.red,
                                                 //     borderRadius: BorderRadius.all(Radius.circular(10))
                                                 // ),
                                                 child: Text('Direction',style: TextStyle(color: MyColors.white,fontWeight: FontWeight.bold),),
                                               ),
                                               onTap: (){
                                                 _navigateLocationDirection(18.706655,74.106762);

                                               },
                                             ),
                                         )

                                       ],
                                     ),
                                 ),

                               ],
                             )

                       ),
                      ]
                     ),
                   );
            }),
          ]);
        });
  }











}
