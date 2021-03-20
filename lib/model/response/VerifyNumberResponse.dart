import 'dart:convert';

VerifyNumberResponse verifyNumberFromJson(String str) => VerifyNumberResponse.fromJson(json.decode(str));

String verifyNumberToJson(VerifyNumberResponse data) => json.encode(data.toJson());

class VerifyNumberResponse {
  VerifyNumberResponse({
    this.status,
    this.message,
    this.otp,
  });

  int status;
  String message;
  String otp;

  factory VerifyNumberResponse.fromJson(Map<String, dynamic> json) => VerifyNumberResponse(
    status: json["Status"],
    message: json["Message"],
    otp: json["OTP"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "OTP": otp,
  };
}
