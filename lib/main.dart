import 'package:flutter/material.dart';
import 'package:mechon/firebase/LocalNotification.dart';
import 'package:mechon/firebase/NotificationService.dart';
import 'package:mechon/screen/home/garage/GarageDetailScreen.dart';
import 'package:mechon/screen/home/garage/GarageHomeScreen.dart';
import 'package:mechon/screen/home/garage/GarageRequestScreen.dart';
import 'package:mechon/screen/home/user/UserHomeScreen.dart';
import 'package:mechon/screen/login/LoginScreen.dart';
import 'package:mechon/screen/map/neargaragelocations/SelectGarageLocation.dart';
import 'package:mechon/screen/mechanic/AddMechanicDetailScreen.dart';
import 'package:mechon/screen/mechanic/MechanicDetailScreen.dart';
import 'package:mechon/screen/registration/garage/GarageRegistrationScreen.dart';
import 'package:mechon/screen/registration/user/UserRegistrationScreen.dart';
import 'package:mechon/screen/splash/splashScreen.dart';
import 'package:mechon/screen/userSelection/UserSelectionScreen.dart';
import 'package:mechon/screen/verify/VerifyMobileNumberScreen.dart';
import 'package:mechon/utility/MyColor.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColors.red,
        accentColor: MyColors.white,
        accentColorBrightness: Brightness.light,
        primarySwatch: MyColors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
     /* routes: <String,WidgetBuilder>{
        '/splashScreen':(BuildContext context) => new SplashScreen(),
        '/userRegistration':(BuildContext context) => new UserRegistrationScreen(),
        '/garageRegistration':(BuildContext context) => new GarageRegistrationScreen(),
        '/verifyNumber':(BuildContext context) => new VerifyMobileNumberScreen(),
        '/userHomePage':(BuildContext context) => new UserHomeScreen(),
      },*/
    );
  }
}
