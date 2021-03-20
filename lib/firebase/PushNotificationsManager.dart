import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mechon/firebase/NotificationService.dart';
import 'package:mechon/firebase/controller/FirebaseTokenRefreshContract.dart';
import 'package:mechon/firebase/presenter/FirebaseTokenRefreshPresenter.dart';
import 'package:mechon/model/notification/Message.dart';
import 'package:mechon/model/response/FirebaseTokenRefreshResponse.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';


// FireabaseMessaging Token : czkKk4_0p07TrWXxc7bpqX:APA91bEGvLTRpIW-J7OtXYkALcbN3yp_z6cWZx_piF-wt8aV-axGwleRjyOt-zHpwbOUVbc-KygNbL9Ae4HpLy1uZtN9tSuS1aJM9aiR9-ZwGkYI5D-5NJ68ulMyvcGO9n1lqWcJYydT
// FireabaseMessaging Token : fKfYRUPURxS4jjfhoCDnS_:APA91bHSmdbtfoayNhS-WA5CYbakQ8K7z-ut3aPCa19n6o-iPTgU-oD1LHVldZcxemfpYGCJVen0JhylwUFOg4xB7WDri6JYObAgaUgsmxfCPy-VjKMT-Zuz55nGvnB_fQooW4OQXo42
class PushNotificationsManager{

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance=PushNotificationsManager._();

  static final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
  static bool _initialized=false;
  static final List<Message> messages=[];
  static String token;


  static Future<void> init() async{
    if(!_initialized){
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();
      token=await _firebaseMessaging.getToken();
      SessionManager.init();
      SessionManager.setFirebaseToken(token);
      print("FireabaseMessaging Token : $token");
    }
  }

   static Future<void> sendNotification()  {
      _firebaseMessaging.configure(
          // onBackgroundMessage: myBackgroundHandler,
      onMessage: (Map<String,dynamic> message) async{
        print("onMessage ******: $message");

        final notification=message['notification'];
        // NotificationService.show_notification(message);

        // myBackgroundHandler(message);
        messages.add(Message(title: notification['title'],body:notification['body']));
        // SessionManager.setNotification(messages);

      },
      onLaunch: (Map<String,dynamic> message) async{
        print("onLaunch *******: $message");
        // myBackgroundHandler(message);
        final notification=message['notification'];
        messages.add(Message(title: notification['title'],body:notification['body']));

      },
      onResume: (Map<String,dynamic> message) async{
        print("onResume ********: $message");
        // myBackgroundHandler(message);
        final notification=message['notification'];
        messages.add(Message(title: notification['title'],body:notification['body']));
      }
    );

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true,badge: true,alert: true,provisional: false)
      // onBackgroundMessage: myBackgroundHandler,

    );
  }


  static Future<void> refreshToken(){
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      token=newToken;
      SessionManager.init();
      SessionManager.setFirebaseToken(token);
    });
  }


  static Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
    print("onBackgroundMessage: $message");

    return NotificationService.show_notification(message);
    // return Future<void>.value();
  }


}