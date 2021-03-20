
import 'dart:convert';

ForgetPasswordRequest forgetPasswordRequestFromJson(String str) => ForgetPasswordRequest.fromJson(json.decode(str));

String forgetPasswordRequestToJson(ForgetPasswordRequest data) => json.encode(data.toJson());

class ForgetPasswordRequest {
  ForgetPasswordRequest({
    this.mobNo,
    this.password,
    this.flag,
  });

  String mobNo;
  String password;
  int flag;

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) => ForgetPasswordRequest(
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
