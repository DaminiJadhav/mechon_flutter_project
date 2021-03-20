import 'package:mechon/model/request/AddMechanicDetailRequest.dart';
import 'package:mechon/model/request/FirebaseTokenRefreshRequest.dart';
import 'package:mechon/model/request/ForgetPasswordRequest.dart';
import 'package:mechon/model/request/GarageLoginRequest.dart';
import 'package:mechon/model/request/GarageRegistrationRequest.dart';
import 'package:mechon/model/request/GarageRequestAcceptRequest.dart';
import 'package:mechon/model/request/MechanicUpdateRequest.dart';
import 'package:mechon/model/request/PostVehicleIssueRequest.dart';
import 'package:mechon/model/request/RejectUserRequestModel.dart';
import 'package:mechon/model/request/UserLoginRequest.dart';
import 'package:mechon/model/request/UserRegistrationRequest.dart';
import 'package:mechon/model/response/AddMechanicDetailResponse.dart';
import 'package:mechon/model/response/FirebaseTokenRefreshResponse.dart';
import 'package:mechon/model/response/ForgetPasswordResponse.dart';
import 'package:mechon/model/response/GarageLoginResponse.dart';
import 'package:mechon/model/response/GarageRegistrationResponse.dart';
import 'package:mechon/model/response/GarageRequestAcceptResponse.dart';
import 'package:mechon/model/response/GetGarageUserAcceptedRequestResponse.dart';
import 'package:mechon/model/response/GetGarageUserRequestResponse.dart';
import 'package:mechon/model/response/GetMechanicDetailResponse.dart';
import 'package:mechon/model/response/GetMechanicSkillResponse.dart';
import 'package:mechon/model/response/GetNearByGarageLocationResponse.dart';
import 'package:mechon/model/response/LogoutResponse.dart';
import 'package:mechon/model/response/MechanicUpdateResponse.dart';
import 'package:mechon/model/response/PostVehicleIssueResponse.dart';
import 'package:mechon/model/response/RejectUserRequestResponse.dart';
import 'package:mechon/model/response/UserLoginResponse.dart';
import 'package:mechon/model/response/UserRegistrationResponse.dart';
import 'package:mechon/model/response/VehicleIssueResponse.dart';
import 'package:mechon/model/response/VehicleTypeListResponse.dart';
import 'package:mechon/model/response/VerifyNumberResponse.dart';
import 'package:mechon/utility/Toast.dart';
import 'package:mechon/utility/Utility.dart';
import 'package:mechon/webService/Repos.dart';
import 'package:http/http.dart' as http;

class ApiService implements Repos{

  String baseUrl = "https://mechon.sdaemon.com//api/";
  Map<String, String> header = {"Content-Type": "application/json"};


  @override
  Future<GarageRegitrationResponse> garageRegistration(GarageRegistrationRequest garageRegistrationRequest) async {
      String newurl=baseUrl+"GarageRegistration/GarageRegistration";
      String postGaragerequest = garageRegistrationRequestToJson(
          garageRegistrationRequest);

      var  garageRegistrationResponse;


      await http.post(newurl,body: postGaragerequest, headers: header).then((value) {
        if (Utility.instance.isAPISuccefull(value.statusCode)) {
          return garageRegistrationResponse=garageRegistrationResponseFromJson(value.body);
        } else {
          throw Exception('Something went wrong');


        }
      }).catchError((error) {
        throw Exception('Something went wrong');


      });
      return garageRegistrationResponse;
  }

  @override
  Future<VehicleTypeListResponse> vehicleTypeList() async{
    String newurl=baseUrl+"VehicleType/GetVehicleType";

    final response=await http.get(newurl);
    var  vehicleListResponse=vehicleTypeFromJson(response.body);

    if(vehicleListResponse.status==1){
      return vehicleListResponse;
    }else{
      throw Exception('Failed To upload Data..');
    }
  }


  //    https://mechon.sdaemon.com/api/OTP/OTPVerification?MobNo=9657431432&Email&flag=1&Roleflag=0
//  @FormUrlEncoded
//    flag =1 for New Password
//    flag=0 for Forget Password
//    Roleflag=0  for  User
//    Roleflag=1  for  Garage

  @override
  Future<VerifyNumberResponse> verifyNumber(String mobNo, String email, int flag, int roleFlag) async{
    String newurl=baseUrl+"OTP/OTPVerification?MobNo="+mobNo+"&Email&flag="+flag.toString()+"&Roleflag="+roleFlag.toString();
    var verifyResponse;

    await http.post(newurl).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return verifyResponse=verifyNumberFromJson(value.body);
      } else {

        throw Exception('Something went wrong');

      }
    }).catchError((error) {
      throw Exception('Something went wrong');


    });
    return verifyResponse;

    }

  @override
  Future<UserRegistrationResponse> userRegistration(UserRegistrationRequest userRegistrationRequest) async{

    String newurl=baseUrl+"Registration/UserRegistration";
    var userRegistration;

    String userRequest=userRegistrationToJson(userRegistrationRequest);



    await http.post(newurl,body: userRequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return userRegistration=userRegistrationResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');


      }
    }).catchError((error) {
      throw Exception('Something went wrong');


    });
    return userRegistration;

  }

  @override
  Future<GarageLoginResponse> garageLogin(GarageLoginRequest garageLoginRequest) async{
    String newurl=baseUrl+"GarageLogin/Login";
    var garageLoginResponse;

    String garageRequest=garageLoginRequestToJson(garageLoginRequest);


    await http.post(newurl,body: garageRequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        garageLoginResponse=garageLoginResponseFromJson(value.body);
        return garageLoginResponse;
      } else {
        // toast().showToast("Something went wrong");
        throw Exception('Something went wrong');

      }
    }).catchError((error) {
      // toast().showToast("Something went wrong");

      throw Exception('Something went wrong');

    });
    return garageLoginResponse;

    // final response=await http.get(newurl);
    // var  vehicleListResponse=vehicleTypeFromJson(response.body);
    //
    // if(vehicleListResponse.status==1){
    //   return vehicleListResponse;
    // }else{
    //   throw Exception('Failed To upload Data..');
    // }

  }

  @override
  Future<UserLoginResponse> userLogin(UserLoginRequest userLoginRequest) async {
    String newurl=baseUrl+"Login/UserLogin";
    UserLoginResponse userLoginResponse;

    String userRequest=userLoginRequestToJson(userLoginRequest);


    await http.post(newurl,body: userRequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        print(value.body);
        userLoginResponse=userLoginResponseFromJson(value.body);
          return userLoginResponse;

      } else {
        // userLoginResponse="Something went wrong";
        throw Exception('Something went wrong');

      }
    }).catchError((error) {
      // userLoginResponse="Something went wrong";
      throw Exception('Something went wrong');


    });
    return userLoginResponse;
  }



  //flag=0   registration
  //flag=1   user


  @override
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest forgetPasswordRequest) async {

    String newurl=baseUrl+"ChangePassword/ForgetPassword";
    var forgetPasswordResponse;

    String userRequest=forgetPasswordRequestToJson(forgetPasswordRequest);


    await http.post(newurl,body: userRequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return forgetPasswordResponse=forgetPasswordResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return forgetPasswordResponse ;
  }

  @override
  Future<VehicleIssueResponse> vehicleIssue() async{
    String newurl=baseUrl+"/Problem/GetProblem";
    var vehicleIssueResponse;


    await http.get(newurl).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return vehicleIssueResponse=vehicleIssueResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return vehicleIssueResponse ;
  }

  @override
  Future<PostVehicleIssueResponse> postvehicleIssue(PostVehicleIssueRequest postVehicleIssueRequest) async {

    String newurl=baseUrl+"UserGarageIssueRequest/PostVehicleIssue";
    var postVehicleIssueResponse;

    String postvehicleRequest=postVehicleIssueRequestToJson(postVehicleIssueRequest);


    await http.post(newurl,body: postvehicleRequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return postVehicleIssueResponse=postVehicleIssueResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return postVehicleIssueResponse ;
  }

  @override
  Future<GetGarageUserAcceptedRequestResponse> getGarageUserIssueDetail(String garageId) async{
    // String newurl=baseUrl+"UserGarageIssueRequest/GetUserGarageIssueRequest?garageId="+garageId;
    String newurl=baseUrl+"GarageRequestAccept/GetUserRequestAccept?garageId="+garageId;

    var getUserIssueDetail;

    await http.get(newurl).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return getUserIssueDetail=getGarageUserAcceptedRequestResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return getUserIssueDetail ;
  }

  @override
  Future<GetNearByGarageLocationResponse> getNearByGarageLocationList(int vehicleTypeId, double userLat, double userLog) async{
    String newurl=baseUrl+"GarageNearByMe/GetGarageNearByMe?vehicleTypeId="+vehicleTypeId.toString()+"&UserLat="+userLat.toString()+"&UserLong="+userLog.toString();
    var getNearGarages;

    await http.get(newurl).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return getNearGarages=getNearByGarageLocationResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return getNearGarages ;
  }

  @override
  Future<GarageRequestAcceptResponse> postGarageRequestAccept(GarageRequestAcceptRequest garageRequestAcceptRequest) async {
    String newurl=baseUrl+"GarageRequestAccept/PostGarageRequestAccept";
    var garageRequestAcceptResponse;
    String postGarageAcceptRequest=garageAcceptRequestToJson(garageRequestAcceptRequest);

    await http.post(newurl,body: postGarageAcceptRequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return garageRequestAcceptResponse=garageRequestAcceptResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return garageRequestAcceptResponse ;
  }

  @override
  Future<GetMechanicSkillResponse> getMechanicSkill() async {
    String newurl=baseUrl+"MechanicSkill/GetMechanicSkill";
    var mechanicSkillResponse;

    await http.get(newurl).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return mechanicSkillResponse=getMechanicSkillResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return mechanicSkillResponse;
  }

  @override
  Future<FirebaseTokenRefreshResponse> postFirebaseToken(FirebaseTokenRefreshRequest firebaseTokenRefreshRequest,int flag) async {
    String newurl;
    if(flag==1){
      newurl=baseUrl+"FireBaseTockenUser/UserFireBaseTocken";
    }else{
      newurl=baseUrl+"FireBaseTockenGarage/GarageFireBaseTocken";
    }

    var firebaseTokenResponse;
    String firebaseTokenRequest=firebaseTokenRefreshRequestToJson(firebaseTokenRefreshRequest);

    await http.post(newurl,body: firebaseTokenRequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return firebaseTokenResponse=firebaseTokenRefreshResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return firebaseTokenResponse ;

  }

  @override
  Future<GetMechanicDetailResponse> getMechanicDetails(int garageId) async{
    String newurl=baseUrl+"MechanicDetail/GetMechanicDetail?garageId="+garageId.toString();
    var mechanicDetailResponse;

    await http.get(newurl).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return mechanicDetailResponse=getMechanicDetailResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return mechanicDetailResponse;
  }

  @override
  Future<AddMechanicDetailResponse> postMechanicDetail(AddMechanicDetailRequest addMechanicDetailRequest) async{
    String newurl=baseUrl+"MechanicDetail/CreateMechanic";
    var postmechanicDetailResponse;
    String postmechanicdetailrequest=addMechanicDetailRequestToJson(addMechanicDetailRequest);

    await http.post(newurl,body: postmechanicdetailrequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return postmechanicDetailResponse=addMechanicDetailResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return postmechanicDetailResponse ;
  }




  // flag =1 User
  // flag =2 Garage

  @override
  Future<LogoutResponse> postLogout(int flag, String id) async {
    // String newurl=baseUrl+"LogOut/SignOut?Flag="+flag.toString()+"&Id="+id;
    String newurl="https://mechon.sdaemon.com//api/LogOut/SignOut?Flag="+flag.toString()+"&Id="+id;

    var logoutResponse;



    await http.post(newurl).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return logoutResponse=logoutResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return logoutResponse ;
  }


  @override
  Future<MechanicUpdateResponse> postUpdatedMechanic(AddMechanicDetailRequest addMechanicDetailRequest) async{
    String newurl=baseUrl+"MechanicDetail/UpdateteMechanic";
    var mechanicupdateresponse;
    String mechanicupdaterequest=addMechanicDetailRequestToJson(addMechanicDetailRequest);

    await http.post(newurl,body: mechanicupdaterequest, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return mechanicupdateresponse=mechanicUpdateResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return mechanicupdateresponse ;
  }

  @override
  Future<RejectUserRequestResponse> postUserRequestReject(RejectUserRequestModel rejectUserRequestModel) async{
    String newurl=baseUrl+"GarageRequestReject/PostGarageRequestReject";
    RejectUserRequestResponse rejectUserRequestResponse;

    String userRequestReject=rejectUserRequestModelToJson(rejectUserRequestModel);


    await http.post(newurl,body: userRequestReject, headers: header).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        print(value.body);
        rejectUserRequestResponse=rejectUserRequestResponseFromJson(value.body);
        return rejectUserRequestResponse;

      } else {
        throw Exception('Something went wrong');

      }
    }).catchError((error) {
      throw Exception('Something went wrong');


    });
    return rejectUserRequestResponse;
  }

  @override
  Future<GetGarageUserRequestResponse> getCurentGarageUserRequest(int garageid) async{
    String newurl=baseUrl+"UserGarageIssueRequest/GetGarageUserRequest?garageId="+garageid.toString();
    var getGarageUserResponse;

    await http.get(newurl).then((value) {
      if (Utility.instance.isAPISuccefull(value.statusCode)) {
        return getGarageUserResponse=getGarageUserRequestResponseFromJson(value.body);
      } else {
        throw Exception('Something went wrong');
      }
    }).catchError((error) {
      throw Exception('Something went wrong');
    });
    return getGarageUserResponse;
  }










}