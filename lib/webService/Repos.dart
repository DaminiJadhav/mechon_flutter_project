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

abstract class Repos{


  //vehicle type
  Future<VehicleTypeListResponse> vehicleTypeList();


  //verify number
  Future<VerifyNumberResponse>  verifyNumber(String mobNo,String email,int flag,int roleFlag);

  //registration
  Future<GarageRegitrationResponse> garageRegistration(GarageRegistrationRequest garageRegistrationRequest);
  Future<UserRegistrationResponse>  userRegistration(UserRegistrationRequest userRegistrationRequest);


  //login
  Future<GarageLoginResponse>  garageLogin(GarageLoginRequest garageLoginRequest);
  Future<UserLoginResponse>  userLogin(UserLoginRequest userLoginRequest);


  //forget password
  Future<ForgetPasswordResponse>  forgetPassword(ForgetPasswordRequest forgetPasswordRequest);


  //VEHICLE ISSUE
    Future<VehicleIssueResponse>  vehicleIssue();

    //post vehicle issue
  Future<PostVehicleIssueResponse>  postvehicleIssue(PostVehicleIssueRequest postVehicleIssueRequest);

   //get vehicle issue
  Future<GetGarageUserAcceptedRequestResponse>  getGarageUserIssueDetail(String garageId);

  //get vehicle issue
  Future<GetNearByGarageLocationResponse>  getNearByGarageLocationList(int vehicleTypeId,double userLat,double userLog);

// post garage accept request
  Future<GarageRequestAcceptResponse>  postGarageRequestAccept(GarageRequestAcceptRequest garageRequestAcceptRequest);


  //get mechanic skills
  Future<GetMechanicSkillResponse>  getMechanicSkill();

  // post mechanic detail
  Future<AddMechanicDetailResponse>  postMechanicDetail(AddMechanicDetailRequest addMechanicDetailRequest);


  //get mechanic detail
  Future<GetMechanicDetailResponse>  getMechanicDetails(int garageid);


  //post firebase refresh token
  Future<FirebaseTokenRefreshResponse>  postFirebaseToken(FirebaseTokenRefreshRequest firebaseTokenRefreshRequest,int flag);


  //logout
  Future<LogoutResponse>  postLogout(int flag,String id);

  // Mechanic Update
  Future<MechanicUpdateResponse>  postUpdatedMechanic(AddMechanicDetailRequest addMechanicDetailRequest);


  // Reject user request
  Future<RejectUserRequestResponse>  postUserRequestReject(RejectUserRequestModel rejectUserRequestModel);


  // user request
  Future<GetGarageUserRequestResponse>  getCurentGarageUserRequest(int garageid);



}