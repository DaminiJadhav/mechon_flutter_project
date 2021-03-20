import 'package:mechon/model/response/VehicleTypeListResponse.dart';

abstract class VehicleTypeListContract{

  void getVehicleTypeListSuccess(VehicleTypeListResponse vehicleTypeListResponse);
  void getVehicleTypeListError(String message);
}