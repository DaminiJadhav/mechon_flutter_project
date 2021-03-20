import 'package:flutter/material.dart';
import 'package:mechon/firebase/PushNotificationsManager.dart';
import 'package:mechon/screen/home/garage/GarageHomeScreen.dart';
import 'package:mechon/screen/home/user/UserHomeScreen.dart';
import 'package:mechon/screen/userSelection/UserSelectionScreen.dart';
import 'package:mechon/utility/SessionManager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    SessionManager.init();
    setState(() {
      PushNotificationsManager.init();
      // PushNotificationsManager.sendNotification();
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {

        // if(SessionManager.getSelectedUser()=="User"){
        //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => UserHomeScreen()));
        //
        // }else if(SessionManager.getSelectedUser()=="Mechanic"){
        //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => GarageHomeScreen()));
        //
        // }else{
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => UserSelectionScreen()
        //       ),
        //       ModalRoute.withName("/Home")
        //   );
        // }



        if(SessionManager.getUserId()!=null){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => UserHomeScreen()
              ),
              ModalRoute.withName("/UserHome")
          );
        }else if(SessionManager.getGarageId()!=null){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => GarageHomeScreen(),

              ),
              ModalRoute.withName("/GarageHome")
          );
        }else{
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => UserSelectionScreen()
              ),
              ModalRoute.withName("/Home")
          );
        }


      });



    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child:Image.asset("assets/mechon_logo.jpg",width: 250,height: 200,),
        ),
      ),
    );
  }
}
