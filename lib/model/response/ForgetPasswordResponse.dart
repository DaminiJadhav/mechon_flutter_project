

import 'dart:convert';

ForgetPasswordResponse forgetPasswordResponseFromJson(String str) => ForgetPasswordResponse.fromJson(json.decode(str));

String forgetPasswordResponseToJson(ForgetPasswordResponse data) => json.encode(data.toJson());

class ForgetPasswordResponse {
  ForgetPasswordResponse({
    this.status,
    this.message,
    this.response,
  });

  int status;
  String message;
  Response response;

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => ForgetPasswordResponse(
    status: json["Status"],
    message: json["Message"],
    response: Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Response": response.toJson(),
  };
}

class Response {
  Response({
    this.mobNo,
    this.password,
    this.flag,
  });

  String mobNo;
  String password;
  int flag;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    mobNo: json["MobNo"],
    password: json["Password"],
    flag: json["Flag"],
  );

  Map<String, dynamic> toJson() => {
    "MobNo": mobNo,
    "Password": password,
    "Flag": flag,
  };
}
