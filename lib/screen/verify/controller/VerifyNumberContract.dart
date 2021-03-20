import 'package:mechon/model/response/VerifyNumberResponse.dart';

abstract class VerifyNumberContract{

  void verifyNumberSuccess(VerifyNumberResponse verifyNumberResponse);
  void verifyNumberError(String message);
}