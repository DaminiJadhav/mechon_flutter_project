import 'package:mechon/model/response/VehicleIssueResponse.dart';

abstract class VehicleIssueContract{

  void getVehicleIssueListSuccess(VehicleIssueResponse vehicleIssueResponse);
  void getVehicleIssueListError(String message);
}