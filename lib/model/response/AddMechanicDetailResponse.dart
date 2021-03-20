// To parse this JSON data, do
//
//     final addMechanicDetailResponse = addMechanicDetailResponseFromJson(jsonString);

import 'dart:convert';

AddMechanicDetailResponse addMechanicDetailResponseFromJson(String str) => AddMechanicDetailResponse.fromJson(json.decode(str));

String addMechanicDetailResponseToJson(AddMechanicDetailResponse data) => json.encode(data.toJson());

class AddMechanicDetailResponse {
  AddMechanicDetailResponse({
    this.status,
    this.message,
    this.mechanicId,
  });

  int status;
  String message;
  int mechanicId;

  factory AddMechanicDetailResponse.fromJson(Map<String, dynamic> json) => AddMechanicDetailResponse(
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
