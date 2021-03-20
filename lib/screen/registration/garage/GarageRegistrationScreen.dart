import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/model/model/VehicleTypeAndId.dart';
import 'package:mechon/model/request/GarageRegistrationRequest.dart';
import 'package:mechon/model/response/GarageRegistrationResponse.dart';
import 'package:mechon/model/response/VehicleTypeListResponse.dart';
import 'package:mechon/screen/login/LoginScreen.dart';
import 'package:mechon/screen/map/GetGarageAddresseMap.dart';
import 'package:mechon/screen/registration/garage/SelectYourGarageType.dart';
import 'package:mechon/screen/registration/garage/controller/GarageRegistrationContract.dart';
import 'package:mechon/screen/registration/garage/presenter/GarageRegistrationPresenter.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';

class GarageRegistrationScreen extends StatefulWidget {
  String mobilenumber;
  GarageRegistrationScreen({this.mobilenumber});

  @override
  _GarageRegistrationScreenState createState() => _GarageRegistrationScreenState();
}

class _GarageRegistrationScreenState extends State<GarageRegistrationScreen> implements GarageRegistrationContract {


  GarageRegistrationPresenter _garageRegistrationPresenter;
  GarageRegitrationResponse garageRegitrationResponse;


  TextEditingController garageNameController=new TextEditingController();
  TextEditingController personNameController=new TextEditingController();
  TextEditingController selectYourProblemController=new TextEditingController();
  TextEditingController emailIdController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  TextEditingController mobileNoController=new TextEditingController();
  TextEditingController addressController=new TextEditingController();

  TextEditingController noOfMechanicController=new TextEditingController();
  TextEditingController mechanicNameController=new TextEditingController();
  TextEditingController mechanicNumberController=new TextEditingController();
  TextEditingController bankNameController=new TextEditingController();
  TextEditingController accountNoController=new TextEditingController();

  TextEditingController ifscCodeController=new TextEditingController();
  TextEditingController upiPayIdController=new TextEditingController();
  TextEditingController upiPayNoController=new TextEditingController();

  // final FirebaseMessaging _messaging=FirebaseMessaging();
  // bool _intialized=false;
  // // final List<Message> messages=[];

  static String mobileNumber = r'(^[789]\d{9}$)';
  static Pattern emailAddress =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regexEmail = new RegExp(emailAddress);
  RegExp regexMobile = new RegExp(mobileNumber);
  bool _isloading = false;



  final formkey = GlobalKey<FormState>();




  // double latitude;
  // double logitude;
  String latitude;
  String logitude;


  var results;
  var garageAddress;
  String address;
  List<dynamic> garageTypeId=new List();
  List<dynamic> garageidList=new List();
  List<dynamic> garageTypeList=new List();
  List<VehicleType> vehicleTypeSelected = new List();

  bool isGarageId=false;
  bool isVisiblePassword=true;

  String token;




  _GarageRegistrationScreenState(){
    _garageRegistrationPresenter=new GarageRegistrationPresenter(this);
  }

  @override
  void initState() {
    SessionManager.init();
    token=SessionManager.getFirebaseToken();
    // token="ghfdgh";
    // toast().showToast(token);
    mobileNoController.text=widget.mobilenumber;
    // getCurrentLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      // appBar: CurveAppBar.getAppbar("Registration", context),
      body:  _garageRegistration(),
    );
  }

  Widget _garageRegistration() {
    return LoadingOverlay(
      isLoading:_isloading ,
      opacity: 0.5,
      color: Colors.white,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: MyColors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: garageNameController,
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
                      labelText: 'Garage Name',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(garageNameController.text.isEmpty){
                        return "Please Enter Garage Name";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: personNameController,
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
                      labelText: 'Person Name',
                      contentPadding: EdgeInsets.only(left: 10.0),


//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(personNameController.text.isEmpty){
                        return "Please Enter Person Name";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: mobileNoController,
                    enabled: false,
                    keyboardType: TextInputType.number,
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
                    validator: (value){
                      if(mobileNoController.text.isEmpty){
                        return "Please Enter Mobile Number";
                      }else if (!regexMobile.hasMatch(mobileNoController.text)) {
                        return "Please Enter Valid Mobile Number";
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _displaySelectedGarageType(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => SelectYourGarageType()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.red[200]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text('Select Your Garage'),
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
                              Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                            ],

                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child:  Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                        // )

                      ],
                    ),
                  ),
                ),
                if(isGarageId)  ListView.builder(
                    shrinkWrap: true,
                    itemCount: vehicleTypeSelected.length,
                    itemBuilder: (context,int index){
                      return Container(
                        child:Text(vehicleTypeSelected[index].vehicleType,style: TextStyle(fontSize: 16),),
                      );
                    }
                ),
              /*  if(!isGarageId)  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 3),
                    child: Text("Please Select Garage Type",style: TextStyle(color: Colors.red,fontSize: 13),)
                ),*/
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0,top: 8),
                  child: TextFormField(
                    controller: emailIdController,
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
                      labelText: 'Email-Id',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(emailIdController.text.isEmpty){
                        return "Please Enter Email-Id";
                      }else if(!EmailValidator.validate(emailIdController.text.trim())){
                        return "Please Enter Valid Email-Id";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: passwordController,
                    enabled: true,
                    obscureText: isVisiblePassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: MyColors.red[200],
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: isVisiblePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            isVisiblePassword=!isVisiblePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: MyColors.red,
                          )),
                      labelText: 'Password',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(passwordController.text.isEmpty){
                        return "Please Enter Password ";
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _getGarageLocation(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: MyColors.red[200])
                      ),
                      child: TextFormField(
                        controller: addressController,
                        enabled: false,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Address',
                          contentPadding: EdgeInsets.only(left: 10.0,top: 10),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                        ),
                        validator: (value){
                          if(addressController.text.isEmpty){
                            return "Please Enter Address ";
                          }
                        },
                      ),

                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextField(
                    controller: noOfMechanicController,
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
                      labelText: 'No of Mechanic',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextField(
                    controller: mechanicNameController,
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
                      labelText: 'Mechanic Name',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextField(
                    controller: mechanicNumberController,
                    enabled: true,
                    keyboardType: TextInputType.number,
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
                      labelText: 'Mechanic Number',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: bankNameController,
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
                      labelText: 'Bank Name',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(bankNameController.text.isEmpty){
                        return "Please Enter Bank Name ";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: accountNoController,
                    enabled: true,
                    keyboardType: TextInputType.number,
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
                      labelText: 'Account No',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(accountNoController.text.isEmpty){
                        return "Please Enter Account Number ";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: ifscCodeController,
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
                            color: Colors.red,
                          )),
                      labelText: 'IFSC Code',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(ifscCodeController.text.isEmpty){
                        return "Please Enter IFSC Code ";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: upiPayIdController,
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
                      labelText: 'UPI Payment Id',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(upiPayIdController.text.isEmpty){
                        return "Please Enter UPI Payment ID ";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: upiPayNoController,
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
                      labelText: 'UPI Payment No',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(upiPayNoController.text.isEmpty){
                        return "Please Enter UPI Payment Number ";
                      }
                    },
                  ),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 30),
                    child: Text('Registration',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)),
                    padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onTap: (){
                    // _postGarageDetail();
                    // if(validation()){
                    //   toast().showToast("success");
                    // }else{
                    //   toast().showToast("failed");
                    // }

                    validation();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future _displaySelectedGarageType(BuildContext context) async {
     results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SelectYourGarageType();
    }));

    if (results != null && results.containsKey('GARAGETYPESID')) {

      garageTypeId=results.entries.map((entry) => "${entry.value}").toList();


      String garageId=garageTypeId[0];
      setState(() {
        garageidList=json.decode(garageId);

      });




    }
     if (results != null && results.containsKey('GARAGETYPES')) {


       setState(() {
         try {
           garageTypeList = results["GARAGETYPES"];
           // print("Garage Type 1" + garageTypeList[0]);
           /*if(garageTypeList!=null){
             isGarageId=true;
           }else{
             isGarageId=false;
           }*/
         }on Exception catch (exception){
           print(exception);
         };

        });
     }

     if (results != null && results.containsKey('VEHICLETYPESELECTED')) {


       setState(() {
         try {
           vehicleTypeSelected = results["VEHICLETYPESELECTED"];
           if(vehicleTypeSelected!=null){
             isGarageId=true;
           }else{
             isGarageId=false;
           }
           // print("Garage Type 1" + garageTypeList[0]);
           /*if(garageTypeList!=null){
             isGarageId=true;
           }else{
             isGarageId=false;
           }*/
         }on Exception catch (exception){
           print(exception);
         };

       });
     }



  }



  Future _getGarageLocation(BuildContext context) async {
    // garageAddress
    results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return GetGarageAddressMap();
    }));

    if (results != null && results.containsKey('GARAGEADDRESS')) {
        addressController.text=results["GARAGEADDRESS"];

      // print(results);
      // for (var value in results.values){
      //   addressController.text=value;
      // }

    }

    if (results != null && results.containsKey('LATITUDE')) {
      latitude= results["LATITUDE"];
      print("Latitude :"+latitude.toString());

    }

    if (results != null && results.containsKey('LONGITUTE')) {
      logitude = results["LONGITUTE"];
      print("Logitude :"+logitude.toString());

    }
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
        setState(() {
          // latitude=position.latitude;
          // logitude=position.longitude;
          if(latitude!=null && logitude!=null){
            print(latitude.toString()+","+logitude.toString());
          }
        });
      }

      return position;
    } catch (err) {
      print("error :"+err.message);
    }

  }



  _postGarageDetail(){


    List<GarageAndVehicleTypeMappingList> garageAndVehicleList=new List();


    for(int i=0;i<vehicleTypeSelected.length;i++){
      GarageAndVehicleTypeMappingList garageAndVehicleTypeMappingList=new GarageAndVehicleTypeMappingList();
      garageAndVehicleTypeMappingList.vehicleTypeId=vehicleTypeSelected[i].vehicleTypeId;
      garageAndVehicleTypeMappingList.tblVehicleType=vehicleTypeSelected[i].vehicleType;
      garageAndVehicleList.add(garageAndVehicleTypeMappingList);
    }

    /*for(int i=0;i<garageTypeList.length;i++){
      garageAndVehicleTypeMappingList.tblVehicleType=garageTypeList[i];
      garageAndVehicleList.add(garageAndVehicleTypeMappingList);
    }*/


    GarageRegistrationRequest garageRegistrationRequest=new GarageRegistrationRequest(
      garageRegistrationId: null,
      garageName: garageNameController.text,
      garageOwnerName: personNameController.text,
      garageOwnerMobNo: mobileNoController.text,
      garageOwnerEmail: emailIdController.text,
      garageAddress: addressController.text,
      password:passwordController.text,
      garageLatitude:double.parse(latitude),
      garageLongitude: double.parse(logitude),
      bankName: bankNameController.text,
      accountNo: accountNoController.text,
      ifscCode: ifscCodeController.text,
      upiPaymentId: upiPayIdController.text,
      upiPaymentNo: upiPayNoController.text,
      isActive: true,
      userId: "",
      requestId: 1,
      garageFcmTocken:token,
      gstNo: "",
      garageAndVehicleTypeMappingList: garageAndVehicleList
    );

    _garageRegistrationPresenter.postGarageRegistration(garageRegistrationRequest);

  }


  validation(){
    if (formkey.currentState.validate()) {

      if(vehicleTypeSelected.length==0){
        toast().showToast("Please Select Garage Type");
      }else{
        setState(() {
          _isloading=true;
        });
        _postGarageDetail();

        // toast().showToast("succeess");

      }

    }else{
      toast().showToast("not validation");

    }


  }

  @override
  void postGarageRegistrationError(String message) {
    toast().showToast(message);
    setState(() {
      _isloading=false;
    });

  }

  @override
  void postGarageRegistrationSuccess(GarageRegitrationResponse garageRegitrationResponse) {
    toast().showToast(garageRegitrationResponse.message);
    setState(() {
      _isloading=false;
    });
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()),(r) => false);

    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()));
    // Navigator.of(context).pop();

  }


}
