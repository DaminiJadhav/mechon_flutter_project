import 'package:mechon/model/response/GarageLoginResponse.dart';
import 'package:mechon/model/response/UserLoginResponse.dart';

abstract class LoginController{

  void postGarageLoginSuccess(GarageLoginResponse garageLoginResponse);
  void postGarageLoginError(String message);

  void postUserLoginSuccess(UserLoginResponse userLoginResponse);
  void postUserLoginError(String message);
}