// To parse this JSON data, do
//
//     final logoutResponse = logoutResponseFromJson(jsonString);

import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) => LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({
    this.status,
    this.message,
    this.id,
  });

  int status;
  String message;
  String id;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
    status: json["Status"],
    message: json["Message"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Id": id,
  };
}
