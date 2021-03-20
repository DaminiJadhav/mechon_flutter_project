import 'package:flutter/material.dart';
import 'package:mechon/firebase/PushNotificationsManager.dart';
import 'package:mechon/firebase/controller/FirebaseTokenRefreshContract.dart';
import 'package:mechon/firebase/presenter/FirebaseTokenRefreshPresenter.dart';
import 'package:mechon/logout/controller/LogoutController.dart';
import 'package:mechon/logout/presenter/LogoutPresenter.dart';
import 'package:mechon/model/notification/Message.dart';
import 'package:mechon/model/request/FirebaseTokenRefreshRequest.dart';
import 'package:mechon/model/response/FirebaseTokenRefreshResponse.dart';
import 'package:mechon/model/response/LogoutResponse.dart';
import 'package:mechon/screen/login/LoginScreen.dart';
import 'package:mechon/screen/map/neargaragelocations/SelectGarageLocation.dart';
import 'package:mechon/screen/userSelection/UserSelectionScreen.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> with WidgetsBindingObserver implements FirebaseTokenRefreshContract,LogoutController {


  static final List<Message> messages=[];
  FirebaseTokenRefreshPresenter _firebaseTokenRefreshPresenter;
  AppLifecycleState _lifecycleState;


  LogoutPresenter logoutPresenter;
  bool isloading = false;

  String getUserId;
  var results;





  _UserHomeScreenState(){
    _firebaseTokenRefreshPresenter=new FirebaseTokenRefreshPresenter(this);
    logoutPresenter=new LogoutPresenter(this);

  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lifecycleState = state;
      switch(_lifecycleState){
        case AppLifecycleState.resumed :
          print("resume called");
          break;
        case AppLifecycleState.inactive :
          print("In active");
          break;
        case AppLifecycleState.paused :
          print("Paused");
          break;
      }
    });
  }


  @override
  void didUpdateWidget(covariant UserHomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    print("update widget");
    super.didUpdateWidget(oldWidget);

  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    setState(() {
      getUserId=SessionManager.getUserId();
    });

    PushNotificationsManager.refreshToken();
    _postFirebaseToken();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          getUserId!=null ? GestureDetector(
            onTap: (){
              _showLogoutDialog(context);
              // SessionManager.logout();
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => UserSelectionScreen()));
            },

            child: Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: Icon(Icons.logout,color: MyColors.white,),
            ),
          ) : Container(
            child: Text(''),
          ),
        ],
      ),
      // appBar: CurveAppBar.getAppbar("Dashboard", context),
      body: _userHomeButtons(),
    );
  }


  Widget _userHomeButtons(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 30),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _vehicleIssueButton(1,"2 Wheeler",Image.asset("assets/twowheeler.jpg",width: 200,height: 100))),
                    Expanded(child: _vehicleIssueButton(2,"3 Wheeler",Image.asset("assets/threewheeler.png",width: 200,height: 100))),
                  ],
                ),
              ),
              Expanded(
                child:
                Row(
                  children: [
                    Expanded(child: _vehicleIssueButton(3,"4 Wheeler",Image.asset("assets/car.jpg",width: 50))),
                    Expanded(child: _vehicleIssueButton(4,"Big Vehicle",Image.asset("assets/bigvehicle_icon.jpg",width: 50,))),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => SelectGarageLocation(vehicleTypeId: 5)));
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/puncture.png",width:100,height: 100,),
                          Padding(
                            padding: const EdgeInsets.only(top:15.0),
                            child: Text("Puncture",style: TextStyle(fontSize: 14,color: Colors.grey[600])),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              // Expanded(
              //   child:
              //   Row(
              //     children: [
              //       Expanded(child: _vehicleIssueButton("Puncture",Image.asset("assets/puncture.png",width:100,height: 100,))),
              //       // Expanded(child: _vehicleIssueButton("Mechon",Icon(Icons.directions_car,size: 50,))),
              //     ],
              //   ),
              // ),

            ],
          ),
        )
    );
  }



  Widget _vehicleIssueButton(int vehicleTypeIds,String title,Image icon){
    return GestureDetector(
      onTap: () {
        print(title);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => SelectGarageLocation(vehicleTypeId: vehicleTypeIds)));

      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Container(
            height: 300,
            alignment: Alignment.center,
            child: ListTile(
              title: icon,
              subtitle: Padding(
                padding: const EdgeInsets.only(top:8.0,left: 15),
                child: Text(title,style: TextStyle(fontSize: 14,),),
              ),
            ),
          ),
        ),
      ),
    );
  }


  _postFirebaseToken(){
    FirebaseTokenRefreshRequest firebaseTokenRefreshRequest=new FirebaseTokenRefreshRequest();


    if(SessionManager.getSelectedUser()=="User"){

      if(SessionManager.getUserId()!=null){
        firebaseTokenRefreshRequest.id=SessionManager.getUserId();
        firebaseTokenRefreshRequest.userFcmTocken=SessionManager.getFirebaseToken();

        _firebaseTokenRefreshPresenter.postFirebaseTokenRefresh(firebaseTokenRefreshRequest,1);
      }

    }


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

                                    logoutPresenter.logout(1, SessionManager.getUserId());

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
  void postFirebaseTokenRefreshError(String message) {
    toast().showToast("Something Went Wrong");
  }

  @override
  void postFirebaseTokenRefreshSuccess(FirebaseTokenRefreshResponse firebaseTokenRefreshResponse) {
    // toast().showToast(firebaseTokenRefreshResponse.message);
  }

  @override
  void logoutError(String message) {
    setState(() {
      isloading=false;
    });
    Navigator.of(context).pop();

    toast().showToast("Something Went Wrong");

  }

  @override
  void logoutSuccess(LogoutResponse logoutResponse) {
    // toast().showToast(logoutResponse.message);

    setState(() {
      isloading=false;
    });
    Navigator.of(context).pop();

    SessionManager.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => UserSelectionScreen()));
  }

}
