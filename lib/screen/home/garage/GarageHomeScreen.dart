import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/firebase/PushNotificationsManager.dart';
import 'package:mechon/firebase/controller/FirebaseTokenRefreshContract.dart';
import 'package:mechon/firebase/presenter/FirebaseTokenRefreshPresenter.dart';
import 'package:mechon/logout/controller/LogoutController.dart';
import 'package:mechon/logout/presenter/LogoutPresenter.dart';
import 'package:mechon/model/notification/Message.dart';
import 'package:mechon/model/request/FirebaseTokenRefreshRequest.dart';
import 'package:mechon/model/response/FirebaseTokenRefreshResponse.dart';
import 'package:mechon/model/response/LogoutResponse.dart';
import 'package:mechon/screen/home/garage/GarageDetailScreen.dart';
import 'package:mechon/screen/home/garage/GarageRequestScreen.dart';
import 'package:mechon/screen/mechanic/MechanicDetailScreen.dart';
import 'package:mechon/screen/userSelection/UserSelectionScreen.dart';
import 'package:mechon/utility/GarageNavigatorDrawer.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';

class GarageHomeScreen extends StatefulWidget {
  @override
  _GarageHomeScreenState createState() => _GarageHomeScreenState();
}

class _GarageHomeScreenState extends State<GarageHomeScreen> implements FirebaseTokenRefreshContract,LogoutController{

  static  List<Message> messages=[];
  Timer timer;
  FirebaseTokenRefreshPresenter _firebaseTokenRefreshPresenter;
  LogoutPresenter logoutPresenter;
  bool isloading = false;


  _GarageHomeScreenState(){
    _firebaseTokenRefreshPresenter=new FirebaseTokenRefreshPresenter(this);
    logoutPresenter=new LogoutPresenter(this);

  }



  @override
  void initState() {

    PushNotificationsManager.refreshToken();

    _postGarageFirebaseToken();
  }

  //
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("timer cancel");
    timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isloading,
      opacity: 0.5,
      color: Colors.white,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: MyColors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer: _garageHomeDrawer(),
            appBar: new AppBar(
              actions: [],
              // actionsIconTheme: ,
              title: new TabBar(
                  indicatorColor: MyColors.white,
                  unselectedLabelColor: Colors.black,
                  // labelColor: Colors.black,
                  tabs: [
                    Tab(text: 'User Request',),
                    Tab(text: 'User Accepted Request',),
                  ]
              ),
            ),
            body: new TabBarView(
                children: [
                  GarageRequestScreen(timer:timer),
                  GarageDetailScreen()
                  // new Icon(Icons.directions_car,size: 50.0,),
                  // new Icon(Icons.directions_transit,size: 50.0,),
                ]
            ),
          ),
        ),
    );

  }

  _postGarageFirebaseToken(){

    FirebaseTokenRefreshRequest firebaseTokenRefreshRequest=new FirebaseTokenRefreshRequest();

    if(SessionManager.getGarageId()!=null){
      firebaseTokenRefreshRequest.id=SessionManager.getGarageId();
      firebaseTokenRefreshRequest.userFcmTocken=SessionManager.getFirebaseToken();

      _firebaseTokenRefreshPresenter.postFirebaseTokenRefresh(firebaseTokenRefreshRequest,2);
    }
  }

    @override
  void postFirebaseTokenRefreshError(String message) {
      // toast().showToast("Something Went Wrong");
    }

  @override
  void postFirebaseTokenRefreshSuccess(FirebaseTokenRefreshResponse firebaseTokenRefreshResponse) {
    // toast().showToast(firebaseTokenRefreshResponse.message);
  }




  _garageHomeDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(child: Image.asset("assets/mechon_logo.jpg",width: 250,height: 100,)),
            decoration: BoxDecoration(
              color: MyColors.white,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: MyColors.red[800],
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: ListTile(
                    leading: Icon(Icons.home,color: MyColors.white,),
                    title: Text('Home',style: TextStyle(color: MyColors.white),),
                  ),
                ),
                Divider(height: 3,color: MyColors.white),
                // GestureDetector(
                //   onTap: (){
                //
                //   },
                //   child: ListTile(
                //     leading: Icon(Icons.account_circle,color: MyColors.white),
                //     title: Text('Profile',style: TextStyle(color: MyColors.white)),
                //   ),
                // ),
                // Divider(height: 3,color: MyColors.white),
                GestureDetector(
                  onTap: (){
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MechanicDetailScreen(),
                    //       settings: RouteSettings(name: "/MechanicDetail"),
                    //     ),
                    //     ModalRoute.withName("/Mechanic"));
                    Navigator.of(context).pop();

                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => MechanicDetailScreen()));
                  },
                  child: ListTile(
                    leading: Icon(Icons.emoji_people_sharp,color: MyColors.white),
                    title: Text('Add Mechanic',style: TextStyle(color: MyColors.white)),
                  ),
                ),
                Divider(height: 3,color: MyColors.white),
                GestureDetector(
                  onTap: (){

                  },
                  child: ListTile(
                    leading: Icon(Icons.help,color: MyColors.white),
                    title: Text('Help',style: TextStyle(color: MyColors.white)),
                  ),
                ),
                Divider(height: 3,color: MyColors.white),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    _showLogoutDialog(context);

                  },
                  child: ListTile(
                    leading: Icon(Icons.logout,color: MyColors.white),
                    title: Text('Logout',style: TextStyle(color: MyColors.white)),
                  ),
                ),
              ],
            ),

          )


        ],
      ),
    );
  }



    _showLogoutDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Wrap(children: [
              Dialog(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text('Confirm logout',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 15, right: 15, bottom: 10),
                        child:
                        Text('Are you sure you want to Logout? '),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[200],
                        margin: EdgeInsets.only(top: 10),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              child: Text('No',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          Container(
                            height: 48,
                            color: Colors.grey[200],
                            width: 1,
                          ),
                          Expanded(
                              child: FlatButton(
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: MyColors.orangeColorCode,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async{
                                    setState(() {
                                      isloading=true;
                                    });

                                    logoutPresenter.logout(2, SessionManager.getGarageId());
                                  }))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }

  @override
  void logoutError(String message) {
    setState(() {
      isloading=false;
    });
    Navigator.of(context).pop();

    // toast().showToast("Something Went Wrong");

  }

  @override
  void logoutSuccess(LogoutResponse logoutResponse) {
    setState(() {
      isloading=false;
    });
    Navigator.of(context).pop();
    SessionManager.garageLogout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => UserSelectionScreen()));
    // toast().showToast(logoutResponse.message);
  }
}
