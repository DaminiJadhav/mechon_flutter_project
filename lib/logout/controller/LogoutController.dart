import 'package:mechon/model/response/LogoutResponse.dart';

abstract class LogoutController{

  void logoutSuccess(LogoutResponse logoutResponse);
  void logoutError(String message);

}