// To parse this JSON data, do
//
//     final userLoginRequest = userLoginRequestFromJson(jsonString);

import 'dart:convert';

GarageRequestAcceptRequest garageAcceptRequestFromJson(String str) => GarageRequestAcceptRequest.fromJson(json.decode(str));

String garageAcceptRequestToJson(GarageRequestAcceptRequest data) => json.encode(data.toJson());

class GarageRequestAcceptRequest {
  GarageRequestAcceptRequest({
    this.GarageId,
    this.UserId,
    this.RequestId,

  });

  String GarageId;
  String UserId;
  String RequestId;


  factory GarageRequestAcceptRequest.fromJson(Map<String, dynamic> json) => GarageRequestAcceptRequest(
    GarageId: json["GarageId"],
    UserId: json["UserId"],
    RequestId: json["RequestId"],

  );

  Map<String, dynamic> toJson() => {
    "GarageId": GarageId,
    "UserId": UserId,
    "RequestId": RequestId,

  };
}
