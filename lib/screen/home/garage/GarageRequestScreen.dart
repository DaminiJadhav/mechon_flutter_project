import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/model/notification/Message.dart';
import 'package:mechon/model/request/GarageRequestAcceptRequest.dart';
import 'package:mechon/model/request/RejectUserRequestModel.dart';
import 'package:mechon/model/response/GarageRequestAcceptResponse.dart';
import 'package:mechon/model/response/GetGarageUserRequestResponse.dart';
import 'package:mechon/model/response/RejectUserRequestResponse.dart';
import 'package:mechon/screen/home/garage/controller/GarageUserRequestContract.dart';
import 'package:mechon/screen/home/garage/presenter/GarageUserRequestPresenter.dart';
import 'package:mechon/screen/home/garage/shimmer/UserRequestShimmer.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';



class GarageRequestScreen extends StatefulWidget {
  Timer timer;

  GarageRequestScreen({this.timer});

  @override
  _GarageRequestScreenState createState() => _GarageRequestScreenState();
}

class _GarageRequestScreenState extends State<GarageRequestScreen>
    with TickerProviderStateMixin
    implements GarageUserRequestContract {
  static List<Message> messages = [];
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  GarageUserRequestPresenter _garageAcceptRequestPresenter;
  List<UserGarageIssueRequest> userGarageIssueRequestList = new List();

  // var timer;
  var timeFormat = DateFormat("HH:mm:ss");
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
  int userRequestIndex;

  var startTime, endTime;
  int time;
  Timer _timer;
  int _start = 100;
  bool _isloading = false;
  int _counter = 0;
  AnimationController _controller;
  int levelClock = 120;

  _GarageRequestScreenState() {
    _garageAcceptRequestPresenter = new GarageUserRequestPresenter(this);
  }

  @override
  void initState() {
    sendNotification();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        );

    _controller.forward();

    // StartTimer();

    // DateTime dateTime = dateFormat.parse("2021-02-19T12:00:00");
    // DateTime dateTime1 = dateFormat.parse("2021-02-19T12:09:00");
    //
    //
    // print("${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}");
    // print("${dateTime1.hour} : ${dateTime1.minute} : ${dateTime.second}");
    //
    // print("${endTime.difference(startTime)}");
    //
    //--------------------------

    // startTime="${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}";
    // endTime="${dateTime1.hour} : ${dateTime1.minute} : ${dateTime.second}";

    // startTime =timeFormat.parse("2021-02-19T12:00:00");
    // endTime=timeFormat.parse("2021-02-19T12:09:00");
    //
    //
    //
    // var timeFormat =DateFormat("HH:mm:ss");

    // startTime =timeFormat.parse("2021-02-19T12:58:41.947");
    // print("Time ${startTime}");

    // startTime =timeFormat.parse("2021-02-19T12:58:41.947");
    // print("Time ${startTime}");

    _garageAcceptRequestPresenter
        .getCurrentUserGarageRequest(int.parse(SessionManager.getGarageId()));

    widget.timer = Timer.periodic(Duration(seconds: 50), (Timer t) => requestListCall());

    // if (_start < 1) {
    //   timer.cancel();
    // } else {
    //   _start = _start - 1;
    // }
    // PushNotificationsManager.sendNotification();
  }

  @override
  void dispose() {
    print("timer cancel");
    _controller.dispose();
    widget.timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("firebase"),
        // ),
        // body: Container(
        //   child:RaisedButton(
        //     child: Text("click"),
        //     onPressed: (){
        //       _rejectGarageUserRequest();
        //     },
        //   ),
        // ),
        body: userGarageIssueRequestList.length != 0
            ? LoadingOverlay(
                isLoading: _isloading,
                opacity: 0.5,
                color: Colors.white,
                progressIndicator: CircularProgressIndicator(
                  backgroundColor: MyColors.red,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: userGarageIssueRequestList.length,
                  itemBuilder: (context, int position) {
                    return buildmessgae(position);
                  },
                  // children: userGarageIssueRequest.map(buildmessgae).toList(),
                  // children: messages.map(buildmessgae).toList(),
                ),
              )
            : UserRequestShimmer()
        // ):Container(
        //   // child: Text(StartTimer()),
        //   child: Text(""),
        //   // child: Text(_start.toString()),
        //
        // ),
        );
  }

  Widget buildmessgae(int position) {
    return Card(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(userGarageIssueRequestList[position]
                                    .firstName)),
                            Container(
                                padding: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(userGarageIssueRequestList[position]
                                    .lastName)),
                          ],
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                userGarageIssueRequestList[position].mobNo)),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(userGarageIssueRequestList[position]
                                .userAddress)),
                        if (userGarageIssueRequestList[position].problem !=
                            null)
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(userGarageIssueRequestList[position]
                                  .problem)),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(userGarageIssueRequestList[position]
                                .assignProblemToUserId
                                .toString())),
                      ],
                    ),
                  ),
                ),
    //             Container(
    //               child: Countdown(
    //                 animation: StepTween(
    //                   begin: getTiming(
    //                       userGarageIssueRequestList[position].currentDateTime,userGarageIssueRequestList[position].endDateTime,position),
    //                   // THIS IS A USER ENTERED NUMBER
    //                   end: 0,
    //                 ).animate(_controller),
    //               ),
    // //               //   child:Text("12:00:00")
    // //               /*    child:Text("${timeFormat.parse("${dateFormat.parse("${userGarageIssueRequest[0].endDateTime}").hour} : ${dateFormat.parse("${userGarageIssueRequest[0].endDateTime}").minute} : ${dateFormat.parse("${userGarageIssueRequest[0].endDateTime}").second}").difference(timeFormat.parse("${dateFormat.parse("${userGarageIssueRequest[0].currentDateTime}").hour} : ${dateFormat.parse("${userGarageIssueRequest[0].currentDateTime}").minute} : ${dateFormat.parse("${userGarageIssueRequest[0].currentDateTime}").second}"))}"),
    // //                       child: Text("${timeFormat.parse("${dateFormat.parse("${userGarageIssueRequest[position].endDateTime}").hour} : ${dateFormat.parse("${userGarageIssueRequest[position].endDateTime}").minute} : ${dateFormat.parse("${userGarageIssueRequest[position].endDateTime}").second}").difference(timeFormat.parse("${dateFormat.parse("${userGarageIssueRequest[position].currentDateTime}").hour} : ${dateFormat.parse("${userGarageIssueRequest[position].currentDateTime}").minute} : ${dateFormat.parse("${userGarageIssueRequest[position].currentDateTime}").second}))}"),
    // // child: Text("${timeFormat.parse(userGarageIssueRequest[position].endDateTime).difference(timeFormat.parse(userGarageIssueRequest[position].currentDateTime))}"),*/
    //             )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    userRequestIndex = position;
                    _acceptGarageRequest(position);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.red,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child:
                        Text('Accept', style: TextStyle(color: MyColors.white)),
                  ),
                ),
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  userRequestIndex = position;
                  _rejectGarageUserRequest(position);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Text(
                    'Reject',
                    style: TextStyle(color: MyColors.white),
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }

  _acceptGarageRequest(int position) {
    setState(() {
      _isloading = true;
    });
    GarageRequestAcceptRequest garageRequestAcceptRequest =
        new GarageRequestAcceptRequest();
    garageRequestAcceptRequest.GarageId = SessionManager.getGarageId();
    garageRequestAcceptRequest.UserId =
        userGarageIssueRequestList[position].userId;
    garageRequestAcceptRequest.RequestId =
        userGarageIssueRequestList[position].assignProblemToUserId.toString();

    _garageAcceptRequestPresenter
        .postGarageAcceptRequest(garageRequestAcceptRequest);
  }

  _rejectGarageUserRequest(int position) {
    setState(() {
      _isloading = true;
    });
    RejectUserRequestModel rejectUserRequestModel =
        new RejectUserRequestModel();
    rejectUserRequestModel.garageId = int.parse(SessionManager.getGarageId());
    rejectUserRequestModel.userId = userGarageIssueRequestList[position].userId;
    rejectUserRequestModel.requestId =
        userGarageIssueRequestList[position].assignProblemToUserId;

    _garageAcceptRequestPresenter
        .postGarageUserRejectRequest(rejectUserRequestModel);
  }

  Future<void> sendNotification() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      setState(() {
        print("onMessage ******: $message");

        final notification = message['notification'];
        toast().showToast("" + notification['body']);
        // userGarageIssueRequestList.clear();
        _garageAcceptRequestPresenter.getCurrentUserGarageRequest(
            int.parse(SessionManager.getGarageId()));

        messages.add(
            Message(title: notification['title'], body: notification['body']));
      });
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch *******: $message");
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume ********: $message");
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('Setting Registered : $settings');
    });
  }

  @override
  void postGarageAcceptRequestError(String message) {
    setState(() {
      _isloading = false;
    });
    // toast().showToast(message);
  }

  @override
  void postGarageAcceptRequestSuccess(
      GarageRequestAcceptResponse garageRequestAcceptResponse) {
    setState(() {
      _isloading = false;
    });
    userGarageIssueRequestList.removeAt(userRequestIndex);
    print(userGarageIssueRequestList.length);

    toast().showToast(garageRequestAcceptResponse.message);
  }

  @override
  void postGarageUserRejectRequestError(String message) {
    setState(() {
      _isloading = false;
    });
    toast().showToast(message);
  }

  @override
  void postGarageUserRejectRequestSuccess(
      RejectUserRequestResponse rejectUserRequestResponse) {
    if (rejectUserRequestResponse.status == 1) {
      setState(() {
        _isloading = false;
      });
      userGarageIssueRequestList.removeAt(userRequestIndex);

      toast().showToast(rejectUserRequestResponse.message);
    } else {
      setState(() {
        _isloading = false;
      });
      toast().showToast(rejectUserRequestResponse.message);
    }
  }

  @override
  void getGarageUserRequestError(String message) {
    // toast().showToast("Something Went Wrong");
  }

  @override
  void getGarageUserRequestSuccess(
      GetGarageUserRequestResponse getGarageUserRequestResponse) {
    if (getGarageUserRequestResponse.status == 1) {
      setState(() {
        userGarageIssueRequestList.clear();
        userGarageIssueRequestList
            .addAll(getGarageUserRequestResponse.userGarageIssueRequest);

        // userGarageIssueRequestList=getGarageUserRequestResponse.userGarageIssueRequest;
      });

      // print("${timeFormat.parse(userGarageIssueRequest[0].endDateTime).difference(timeFormat.parse(userGarageIssueRequest[0].currentDateTime))}");

      // toast().showToast(getGarageUserRequestResponse.message);
    } else {
      // setState(() {
      //   _isloading=false;
      // });
      // toast().showToast(getGarageUserRequestResponse.message);
    }
  }

  void requestListCall() {
    print("call api");
    setState(() {
      userGarageIssueRequestList.clear();
      _garageAcceptRequestPresenter
          .getCurrentUserGarageRequest(int.parse(SessionManager.getGarageId()));
    });
  }

  void StartTimer() {
    const onesec = const Duration(hours: 00, minutes: 01, seconds: 3);
    _timer = new Timer.periodic(onesec, (timer) {
      setState(() {
        // print(time);
        if (_start < 1) {
          print('timer cancel');
          timer.cancel();
        } else {
          _start = _start - 1;
          print('timer start counting');
        }
      });
    });

    //
// DateTime dateTime = dateFormat.parse("2021-02-19T12:00:45");
// DateTime dateTime1 = dateFormat.parse("2021-02-19T12:09:50");
//
// print("${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
// print("${dateTime1.hour}:${dateTime1.minute}:${dateTime1.second}");
//
// var timeFormat =DateFormat("HH:mm:ss");
// startTime =timeFormat.parse("${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
// endTime=timeFormat.parse("${dateTime1.hour}:${dateTime1.minute}:${dateTime1.second}");
//
// // DateTime dateTime = dateFormat.parse("2021-02-19T12:58:41");
// // print(dateTime);
// // print("${dateTime.hour} : ${dateTime.minute}");
// //
// time=endTime.difference(startTime);
// DateTime getTime = dateFormat.parse(time);
  }

  int getTiming(String currentDateTime, String endDateTime,int position) {
//    var now = new DateTime.now();
  //  var dateTime = dateFormat.format(now);
    final DateTime now = DateTime.now();
//    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = dateFormat.format(now);
    print(formatted);
    DateTime dateTime = dateFormat.parse(formatted);
    DateTime dateTime1 = dateFormat.parse(endDateTime);

    print("${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
    print("${dateTime1.hour}:${dateTime1.minute}:${dateTime1.second}");

    var timeFormat = DateFormat("HH:mm:ss");
    dynamic startTime = timeFormat
        .parse("${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
    dynamic endTime = timeFormat
        .parse("${dateTime1.hour}:${dateTime1.minute}:${dateTime1.second}");

// DateTime dateTime = dateFormat.parse("2021-02-19T12:58:41");
// print(dateTime);
// print("${dateTime.hour} : ${dateTime.minute}");
//
    Duration time = endTime.difference(startTime);
    print(time.inSeconds);
    // if(time.inSeconds==0){
    //   setState(() {
    //     userGarageIssueRequestList.removeAt(position);
    //   });
    // }else{
    //
    // }

/*    DateTime getTime = dateFormat.parse(time);*/
    return time.inSeconds;
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {


    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    print('animation.value  ${animation.value} ');
    print('inMinutes ${clockTimer.inMinutes.toString()}');
    print('inSeconds ${clockTimer.inSeconds.toString()}');
    print(
        'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
