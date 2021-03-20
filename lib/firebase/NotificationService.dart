import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static FlutterLocalNotificationsPlugin  flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  static  AndroidInitializationSettings androidInitializationSettings;
  static IOSInitializationSettings iosInitializationSettings;
  static InitializationSettings initializationSettings;



  static Future<void> initializing() async{
    androidInitializationSettings=AndroidInitializationSettings("@mipmap/ic_launcher");
    iosInitializationSettings =IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings=InitializationSettings(android: androidInitializationSettings,iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
  }


  static Future<void> show_notification(Map<String,dynamic> message) async{
    await notification(message);
  }

  static Future onSelectNotification(String payload){
    if(payload!=null){
      print(payload);
    }
    // await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future onDidReceiveLocalNotification(int id,String title,String body,String paayload) async{
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: (){
            print("");
          },
        )
      ],
    );
  }


  static Future<void> notification(Map<String,dynamic> message) async{
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
        'channel_id',
        'channel_title',
        'channel body',
        priority: Priority.high,
        importance:Importance.max,
        ticker: 'test'
    );
    IOSNotificationDetails iosNotificationDetails=IOSNotificationDetails();
    NotificationDetails notificationDetails=NotificationDetails(android: androidNotificationDetails,iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Hi !!!',
        'This is my first flutter notification',
        notificationDetails,
    );
  }

}