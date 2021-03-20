// To parse this JSON data, do
//
//     final firebaseTokenRefreshResponse = firebaseTokenRefreshResponseFromJson(jsonString);

import 'dart:convert';

FirebaseTokenRefreshResponse firebaseTokenRefreshResponseFromJson(String str) => FirebaseTokenRefreshResponse.fromJson(json.decode(str));

String firebaseTokenRefreshResponseToJson(FirebaseTokenRefreshResponse data) => json.encode(data.toJson());

class FirebaseTokenRefreshResponse {
  FirebaseTokenRefreshResponse({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory FirebaseTokenRefreshResponse.fromJson(Map<String, dynamic> json) => FirebaseTokenRefreshResponse(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
