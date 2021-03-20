
import 'package:mechon/model/response/ForgetPasswordResponse.dart';

abstract class ForgetPasswordController{

  void postForgetPasswordSuccess(ForgetPasswordResponse forgetPasswordResponse);
  void postForgetPasswordError(String message);


}