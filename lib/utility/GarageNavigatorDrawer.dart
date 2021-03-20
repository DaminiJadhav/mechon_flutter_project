import 'package:flutter/material.dart';
import 'package:mechon/screen/home/garage/GarageHomeScreen.dart';
import 'package:mechon/screen/login/LoginScreen.dart';
import 'package:mechon/screen/mechanic/MechanicDetailScreen.dart';
import 'package:mechon/screen/userSelection/UserSelectionScreen.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';

class GarageNavigatorDrawer extends StatefulWidget {
  @override
  _GarageNavigatorDrawerState createState() => _GarageNavigatorDrawerState();
}

class _GarageNavigatorDrawerState extends State<GarageNavigatorDrawer> {


  @override
  void initState() {
    SessionManager.init();
  }
  @override
  Widget build(BuildContext context) {
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MechanicDetailScreen(),
                          settings: RouteSettings(name: "/MechanicDetail"),
                        ),
                        ModalRoute.withName("/Mechanic"));
                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => MechanicDetailScreen()));
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

                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => GarageHomeScreen()));

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




}
