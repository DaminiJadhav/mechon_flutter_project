import 'package:mechon/model/response/GetNearByGarageLocationResponse.dart';

abstract class NearByGarageLocationContract{
  void getNearByGarageLocationSucess(GetNearByGarageLocationResponse garageLocationResponse);
  void getNearByGarageLocationSError(String message);
}