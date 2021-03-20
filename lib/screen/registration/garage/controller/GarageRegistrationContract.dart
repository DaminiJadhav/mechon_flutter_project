import 'package:mechon/model/response/GarageRegistrationResponse.dart';

abstract class GarageRegistrationContract{

  void postGarageRegistrationSuccess(GarageRegitrationResponse garageRegitrationResponse);
  void postGarageRegistrationError(String message);
}