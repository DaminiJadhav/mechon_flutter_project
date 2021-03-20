// To parse this JSON data, do
//
//     final userLoginRequest = userLoginRequestFromJson(jsonString);

import 'dart:convert';

UserLoginRequest userLoginRequestFromJson(String str) => UserLoginRequest.fromJson(json.decode(str));

String userLoginRequestToJson(UserLoginRequest data) => json.encode(data.toJson());

class UserLoginRequest {
  UserLoginRequest({
    this.mobNo,
    this.password,
    this.fCMTocken,

  });

  String mobNo;
  String password;
  String fCMTocken;


  factory UserLoginRequest.fromJson(Map<String, dynamic> json) => UserLoginRequest(
    mobNo: json["MobNo"],
    password: json["Password"],
    fCMTocken: json["FCMTocken"],

  );

  Map<String, dynamic> toJson() => {
    "MobNo": mobNo,
    "Password": password,
    "FCMTocken": fCMTocken,

  };
}
