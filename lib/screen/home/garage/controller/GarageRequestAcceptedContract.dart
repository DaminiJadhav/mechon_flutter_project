import 'package:mechon/model/response/GetGarageUserAcceptedRequestResponse.dart';

abstract class GarageRequestAcceptedContract{

  void getGarageUserIssueRequestDetailSuccess(GetGarageUserAcceptedRequestResponse getGarageUserAcceptedRequestResponse);
  void getGarageUserIssueRequestDetailError(String message);
}