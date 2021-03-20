import 'package:mechon/model/response/UserRegistrationResponse.dart';

abstract class UserRegistrationController{
  void postUserRegistrationSuccess(UserRegistrationResponse userRegistrationResponse);
  void postUserRegistrationError(String message);
}