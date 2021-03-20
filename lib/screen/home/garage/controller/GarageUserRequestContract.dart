import 'package:mechon/model/response/GarageRequestAcceptResponse.dart';
import 'package:mechon/model/response/GetGarageUserRequestResponse.dart';
import 'package:mechon/model/response/RejectUserRequestResponse.dart';

abstract class GarageUserRequestContract{

  void postGarageAcceptRequestSuccess(GarageRequestAcceptResponse garageRequestAcceptResponse);
  void postGarageAcceptRequestError(String message);

  void postGarageUserRejectRequestSuccess(RejectUserRequestResponse rejectUserRequestResponse);
  void postGarageUserRejectRequestError(String message);

  void getGarageUserRequestSuccess(GetGarageUserRequestResponse getGarageUserRequestResponse);
  void getGarageUserRequestError(String message);

}