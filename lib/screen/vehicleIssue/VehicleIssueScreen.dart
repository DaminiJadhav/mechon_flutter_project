// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/firebase/PushNotificationsManager.dart';
import 'package:mechon/model/notification/Message.dart';
import 'package:mechon/model/request/PostVehicleIssueRequest.dart';
import 'package:mechon/model/response/PostVehicleIssueResponse.dart';
import 'package:mechon/model/response/VehicleIssueResponse.dart';
import 'package:mechon/model/response/VehicleTypeListResponse.dart';
import 'package:mechon/screen/map/neargaragelocations/SelectGarageLocation.dart';
import 'package:mechon/screen/registration/garage/controller/VehicleTypeListContract.dart';
import 'package:mechon/screen/registration/garage/presenter/VehicleTypeListPresenter.dart';
import 'package:mechon/screen/vehicleIssue/SelectYourPromblemScreen.dart';
import 'package:mechon/screen/vehicleIssue/controller/PostVehicleIssueContract.dart';
import 'package:mechon/screen/vehicleIssue/presenter/PostVehicleIssuePresenter.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';

import '../home/user/UserHomeScreen.dart';

class VehicleIssueScreen extends StatefulWidget {
  @override
  _VehicleIssueScreenState createState() => _VehicleIssueScreenState();
}

class _VehicleIssueScreenState extends State<VehicleIssueScreen>
    implements VehicleTypeListContract, PostVehicleIssueContract {
  TextEditingController mobileController = new TextEditingController();
  TextEditingController vehicleNumberController = new TextEditingController();
  TextEditingController selectYourProblemController =
      new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  DateTime now = DateTime.now();
  String convertedDateTime;

  List<String> locations = ['A', 'B', 'C', 'D'];
  String dropdownValue;
  var results;
  String otherIssue, selectedVehicleType;
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  final List<Message> messages = [];
  List<VehicleIssueType> vehicleTypeSelected = new List();
  VehicleTypeListPresenter vehicleTypeListPresenter;
  PostVehicleIssuePresenter postVehicleIssuePresenter;
  List<VehicleType> vehicleType = new List();

  bool _isloading = false;
  final formkey = GlobalKey<FormState>();

  static String mobileNumber = r'(^[789]\d{9}$)';
  RegExp regexMobile = new RegExp(mobileNumber);

  static String vehicleNumber =
      r"^[A-Z|a-z]{2}\s?[0-9]{1,2}\s?[A-Z|a-z]{0,3}\s?[0-9]{4}$";

  RegExp regexvehicleNumber = new RegExp(vehicleNumber);

  double latitude;
  double longitute;
  static LatLng latLng;
  String currentAddress;

  _VehicleIssueScreenState() {
    vehicleTypeListPresenter = new VehicleTypeListPresenter(this);
    postVehicleIssuePresenter = new PostVehicleIssuePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    // PushNotificationsManager.sendNotification();


    SessionManager.init();
    mobileController.text = SessionManager.getUserName();
    // DateTime now = DateTime.now();
    // dateTime=new DateTime(now.year,now.month,now.day,now.hour);
    now = DateTime.now();
    convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}:${now.minute.toString()}:${now.second.toString()}";
    print("Date :" + convertedDateTime);
    // Date :2021-02-19 13:12:32

    setState(() {
      _isloading = true;
    });
    getCurrentLocation();
    vehicleTypeListPresenter.getVehicleTypeList();

    // PushNotificationsManager.sendNotification();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext cotext) => UserHomeScreen()),(r) => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Vehicle Issue'),
        ),
        // appBar: CurveAppBar.getAppbar("Vehicle Issue", context),
        body: _vehicleIssueForm(),
      ),
    );
  }

  Widget _vehicleIssueForm() {
    return LoadingOverlay(
      isLoading: _isloading,
      opacity: 0.5,
      color: Colors.white,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: MyColors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      child: Container(
        margin: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    enabled: false,
                    maxLength: 10,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: MyColors.red[200],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: MyColors.red,
                          )),
                      labelText: 'Mobile Number',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value) {
                      if (mobileController.text.isEmpty) {
                        return "Please Enter Mobile Number";
                      } else if (!regexMobile.hasMatch(mobileController.text)) {
                        return "Please Enter Valid Mobile Number";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                      controller: vehicleNumberController,
                      enabled: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            width: 1,
                            color: MyColors.red[200],
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                              color: MyColors.red,
                            )),
                        labelText: 'Vehicle Number',
                        contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                      ),
                      validator: (value) {
                        if (vehicleNumberController.text.isEmpty) {
                          return "Please Enter Vehicle Number";
                        }
                        // else if (!regexvehicleNumber.hasMatch(
                        //     vehicleNumberController.text)) {
                        //   return "Please Enter Valid Vehicle Number";
                        // }
                      }),
                ),
                Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColors.red[200]),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        iconEnabledColor: Color(0xFF595959),
                        items: vehicleType.map((returnValue) {
                          return DropdownMenuItem<String>(
                            onTap: () {
                              setState(() {
                                selectedVehicleType =
                                    returnValue.vehicleTypeId.toString();
                              });
                            },
                            value: returnValue.vehicleType,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                returnValue.vehicleType,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Select Vehicle Type",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        onChanged: (String returnValue) {
                          setState(() {
                            dropdownValue = returnValue;
                          });
                        },
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    _displaySelectedYourProblem(context);

                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => SelectYourProblemScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColors.red[200]),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text('Select Your Problem'),
                          ),
                          //  Select Your Garage Type
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Container(
                                child: Text('Choose'),
                                margin: EdgeInsets.only(right: 5),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (vehicleTypeSelected.length != 0)
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: vehicleTypeSelected.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          child: Text(
                            vehicleTypeSelected[index].peoblem,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 6),
                  child: TextFormField(
                    controller: descriptionController,
                    enabled: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: MyColors.red[200],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: MyColors.red,
                          )),
                      labelText: 'Description',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 30),
                    child: Text('Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onTap: () {
                    _postVehicleIssue();
                    // PushNotificationsManager.init() ;
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()));
                    // Navigator.pop(context)  ;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _postVehicleIssue() {
    setState(() {
      if (formkey.currentState.validate()) {
        if (vehicleType.length == 0) {
          toast().showToast("Please Select Vehicle Type");
        } else if (vehicleTypeSelected.length == 0) {
          toast().showToast("Please Select Vehicle Issue");
        } else {
          setState(() {
            _isloading = true;
          });
          _postIssue();
          // toast().showToast("success");
        }
      } else {
        // toast().showToast("failed");

      }
    });
  }

  void _postIssue() {
    List<AssignProblemToUserDetailList> assignProblemToUserDetailList =
        new List();

    for (int i = 0; i < vehicleTypeSelected.length; i++) {
      AssignProblemToUserDetailList assignProblemToUserDetail =
          new AssignProblemToUserDetailList();

      assignProblemToUserDetail.problemId = vehicleTypeSelected[i].problemId;
      assignProblemToUserDetail.assignProblemToUserHeaderId = "";

      assignProblemToUserDetailList.add(assignProblemToUserDetail);
    }

    PostVehicleIssueRequest postVehicleIssueRequest =
        new PostVehicleIssueRequest();
    String userid = SessionManager.getUserId();
    postVehicleIssueRequest.userId = userid;
    postVehicleIssueRequest.userLatitude = latitude.toString();
    postVehicleIssueRequest.currentDateTime = convertedDateTime;
    postVehicleIssueRequest.userLongitude = longitute.toString();
    postVehicleIssueRequest.userAddress = currentAddress;
    postVehicleIssueRequest.vehicleNo = vehicleNumberController.text;
    postVehicleIssueRequest.vehicleTypeId = selectedVehicleType;
    postVehicleIssueRequest.description = descriptionController.text;
    postVehicleIssueRequest.other = otherIssue;
    postVehicleIssueRequest.assignProblemToUserDetailList =
        assignProblemToUserDetailList;

    print(latitude.toString() +
        " : " +
        longitute.toString() +
        " : " +
        currentAddress);
    postVehicleIssuePresenter.postVehicleIssue(postVehicleIssueRequest);
  }

  getCurrentLocation() async {
    try {
      // Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
      //
      // Position position = await geolocator.getCurrentPosition(
      //   desiredAccuracy: LocationAccuracy.low,
      // );
      Position position = await Geolocator.getLastKnownPosition();

      if (position != null) {
        print('location success');
        setState(() {
          latitude = position.latitude;
          longitute = position.longitude;

          // print("longitute :"+latitude.toString());
          // print("longitute :"+longitute.toString());

          if (latitude != null && longitute != null) {
            getAddressbaseloacation();
            setState(() {
              latLng = LatLng(latitude, longitute);
            });
            print(latitude.toString() + "," + longitute.toString());
          }
        });
      }

      return position;
    } catch (err) {
      print("error :" + err.message);
    }
  }

  getAddressbaseloacation() async {
    final coordinates = new Coordinates(latitude, longitute);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      currentAddress = address.first.addressLine;
      // print("Address :"+currentAddress);
    });
  }

  Future _displaySelectedYourProblem(BuildContext context) async {
    results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SelectYourProblemScreen();
    }));

    // if (results != null && results.containsKey('VehicleIssue')) {
    //   print(results);
    //
    //
    // }
    if (results != null && results.containsKey('VehicleIssue')) {
      setState(() {
        try {
          vehicleTypeSelected = results["VehicleIssue"];
          print(vehicleTypeSelected);
          print(vehicleTypeSelected);
        } on Exception catch (exception) {
          print(exception);
        }
        ;
      });
    }
    if (results != null && results.containsKey('VehicleIssueText')) {
      otherIssue = results['VehicleIssueText'];
      // for (var value in results.values){
      //   otherIssue=value;
      //   // print(value);
      // }
    }
  }

  @override
  void getVehicleTypeListError(String message) {
    toast().showToast(message);
    setState(() {
      _isloading = false;
    });
  }

  @override
  void getVehicleTypeListSuccess(
      VehicleTypeListResponse vehicleTypeListResponse) {
    // toast().showToast(vehicleTypeListResponse.message);
    setState(() {
      _isloading = false;
      vehicleType = vehicleTypeListResponse.vehicleType;
    });
  }

  @override
  void postVehicleIssueError(String message) {
    toast().showToast(message);

    setState(() {
      _isloading = false;
    });
  }

  @override
  void postVehicleIssueSuccess(
      PostVehicleIssueResponse postVehicleIssueResponse) {
    toast().showToast(postVehicleIssueResponse.message);
    setState(() {
      _isloading = false;
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext cotext) => SelectGarageLocation(
                  vehicleTypeId: int.parse(selectedVehicleType),
                )));
  }
}
