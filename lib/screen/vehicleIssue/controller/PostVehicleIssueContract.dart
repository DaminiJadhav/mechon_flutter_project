import 'package:mechon/model/response/PostVehicleIssueResponse.dart';

abstract class PostVehicleIssueContract{

  void postVehicleIssueSuccess(PostVehicleIssueResponse postVehicleIssueResponse);
  void postVehicleIssueError(String message);
}