// To parse this JSON data, do
//
//     final firebaseTokenRefreshRequest = firebaseTokenRefreshRequestFromJson(jsonString);

import 'dart:convert';

FirebaseTokenRefreshRequest firebaseTokenRefreshRequestFromJson(String str) => FirebaseTokenRefreshRequest.fromJson(json.decode(str));

String firebaseTokenRefreshRequestToJson(FirebaseTokenRefreshRequest data) => json.encode(data.toJson());

class FirebaseTokenRefreshRequest {
  FirebaseTokenRefreshRequest({
    this.id,
    this.userFcmTocken,
  });

  String id;
  String userFcmTocken;

  factory FirebaseTokenRefreshRequest.fromJson(Map<String, dynamic> json) => FirebaseTokenRefreshRequest(
    id: json["Id"],
    userFcmTocken: json["UserFCMTocken"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "UserFCMTocken": userFcmTocken,
  };
}
