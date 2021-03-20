import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/model/response/GetGarageUserAcceptedRequestResponse.dart';
import 'package:mechon/screen/home/garage/controller/GarageRequestAcceptedContract.dart';
import 'package:mechon/screen/home/garage/presenter/GarageRequestAcceptedPresenter.dart';
import 'package:mechon/screen/home/garage/shimmer/UserAcceptedRequestShimmer.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';

class GarageDetailScreen extends StatefulWidget {
  @override
  _GarageDetailScreenState createState() => _GarageDetailScreenState();
}

class _GarageDetailScreenState extends State<GarageDetailScreen> implements GarageRequestAcceptedContract{

  GarageRequestAcceptedPresenter garageHomePagePresenter;
   List<UserGarageIssueRequest> userGarageIssueRequest=new List();
   bool _isloading = false;


   _GarageDetailScreenState(){
     garageHomePagePresenter=GarageRequestAcceptedPresenter(this);
   }


   @override
  void initState() {
     // setState(() {
     //   _isloading=true;
     // });
   garageHomePagePresenter.getGarageUserIssueDetail(SessionManager.getGarageId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading:_isloading ,
        opacity: 0.5,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: MyColors.red,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
        child: userGarageIssueRequest.length!=0 ? ListView.builder(
            itemCount: userGarageIssueRequest.length,
            itemBuilder: (context,int position){
              return Card(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(userGarageIssueRequest[position].firstName)
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 4),
                                          alignment: Alignment.centerLeft,
                                          child: Text(userGarageIssueRequest[position].lastName)
                                      ),
                                    ],
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(userGarageIssueRequest[position].mobNo)
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(userGarageIssueRequest[position].userAddress)
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(userGarageIssueRequest[position].vehicleType)
                                  ),
                                  // Container(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: Text(userGarageIssueRequest[position].assignProblemToUserId.toString())
                                  // )

                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                FlutterPhoneDirectCaller.callNumber(userGarageIssueRequest[position].mobNo);
                              },
                              child: Container(
                                child: Icon(Icons.call),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ) :
        UserAcceptedRequestShimmer()
      ),
    );
  }

  @override
  void getGarageUserIssueRequestDetailError(String message) {
    // setState(() {
    //   _isloading=false;
    // });
    // toast().showToast("Something Went Wrong");
  }


  @override
  void getGarageUserIssueRequestDetailSuccess(GetGarageUserAcceptedRequestResponse garageUserIssueDetailResponse) {
    // setState(() {
    //   _isloading=false;
    // });
    setState(() {
      userGarageIssueRequest=garageUserIssueDetailResponse.userGarageIssueRequest;
    });
     // toast().showToast(garageUserIssueDetailResponse.message);

  }
}
