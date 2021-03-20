import 'package:flutter/material.dart';
import 'package:mechon/screen/home/user/UserHomeScreen.dart';
import 'package:mechon/screen/login/LoginScreen.dart';
import 'package:mechon/utility/SessionManager.dart';

class UserSelectionScreen extends StatefulWidget {
  @override
  _UserSelectionState createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelectionScreen> {

  bool isSelectUser=false;
  bool isSelectMechanic=false;

  @override
  void initState() {
    SessionManager.init();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: isSelectUser || isSelectMechanic ? GestureDetector(
          onTap: (){
            print(SessionManager.getSelectedUser());
            if(SessionManager.getSelectedUser()=="User"){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHomeScreen(),
                    settings: RouteSettings(name: "/HomeScreen"),
                  ),
                  ModalRoute.withName("/Home"));
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => UserHomeScreen()));
            }else{

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen(),
                settings: RouteSettings(name: "/LoginScreen"),
              ),
                ModalRoute.withName("/Login"),
              );
            }
            //     // Navigator.pop(context)  ;
          },
          child: Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 20,left: 10,right: 10),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Next',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.red
            ),
          ),
        ) : Container(
             child: Text(''),
        ),
      ),
      body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  child: Text('Let\'s get to know you',style:TextStyle(fontSize:17))),
              // Image.asset("assets/sdaemon_logo.png",width: 200,height: 100,),
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 15),
                  child: Text('Find the place which belongs to you',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),)),

              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 35),
                  child: isSelectUser ? Icon(Icons.account_circle,size: 55,color: Colors.white,) :Icon(Icons.account_circle,size: 55,color: Colors.grey,),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelectUser ? Colors.red : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border:isSelectUser ? Border.all(color: Colors.white):Border.all(color: Colors.black)
                  ),
                ),
                onTap: (){
                  setState(() {
                    isSelectUser=true;
                    isSelectMechanic=false;
                    if(isSelectUser==true){
                      SessionManager.setSelectedUser("User");
                    }
                  });

                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Text('User',style: TextStyle(fontSize: 16)),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: isSelectMechanic ? Icon(Icons.gavel_rounded,size: 55,color: Colors.white,) : Icon(Icons.gavel_rounded,size: 55,color: Colors.grey),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: isSelectMechanic ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: isSelectMechanic ? Border.all(color: Colors.white) : Border.all(color: Colors.black)
                  ),
                ),
                onTap: (){
                  setState(() {
                    isSelectMechanic=true;
                    isSelectUser=false;
                    if(isSelectMechanic==true){
                      SessionManager.setSelectedUser("Garage");
                    }
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Text('Garage',style: TextStyle(fontSize: 16)),
              ),

            ],
          ),
        ),


    );
  }
}
