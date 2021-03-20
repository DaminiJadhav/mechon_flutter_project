import 'package:mechon/model/response/FirebaseTokenRefreshResponse.dart';

abstract class FirebaseTokenRefreshContract{

  void postFirebaseTokenRefreshSuccess(FirebaseTokenRefreshResponse firebaseTokenRefreshResponse);
  void postFirebaseTokenRefreshError(String message);


}