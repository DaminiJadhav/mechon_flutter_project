// To parse this JSON data, do
//
//     final mechanicUpdateResponse = mechanicUpdateResponseFromJson(jsonString);

import 'dart:convert';

MechanicUpdateResponse mechanicUpdateResponseFromJson(String str) => MechanicUpdateResponse.fromJson(json.decode(str));

String mechanicUpdateResponseToJson(MechanicUpdateResponse data) => json.encode(data.toJson());

class MechanicUpdateResponse {
  MechanicUpdateResponse({
    this.status,
    this.message,
    this.mechanicId,
  });

  int status;
  String message;
  int mechanicId;

  factory MechanicUpdateResponse.fromJson(Map<String, dynamic> json) => MechanicUpdateResponse(
    status: json["Status"],
    message: json["Message"],
    mechanicId: json["MechanicId"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "MechanicId": mechanicId,
  };
}
