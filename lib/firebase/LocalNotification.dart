import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mechon/firebase/NotificationService.dart';
import 'package:mechon/firebase/PushNotificationsManager.dart';
import 'package:mechon/utility/Toast.dart';

class NoticationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeNotificationApp(),
    );
  }
}
class HomeNotificationApp extends StatefulWidget {
  @override
  _HomeNotificationAppState createState() => _HomeNotificationAppState();
}

class _HomeNotificationAppState extends State<HomeNotificationApp> {

  @override
  void initState() {
    super.initState();
    NotificationService.initializing();
    PushNotificationsManager.init();
    PushNotificationsManager.sendNotification();
    // initializing();
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Show Notification'),
            onPressed: (){
              Map<String,dynamic> message;
              NotificationService.show_notification(message);
              // show_notification();
            },
          )
        ],
      ),
    );
  }
}