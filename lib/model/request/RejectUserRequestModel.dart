
import 'dart:convert';

RejectUserRequestModel rejectUserRequestModelFromJson(String str) => RejectUserRequestModel.fromJson(json.decode(str));

String rejectUserRequestModelToJson(RejectUserRequestModel data) => json.encode(data.toJson());

class RejectUserRequestModel {
  RejectUserRequestModel({
    this.garageId,
    this.userId,
    this.requestId,
  });

  int garageId;
  String userId;
  int requestId;

  factory RejectUserRequestModel.fromJson(Map<String, dynamic> json) => RejectUserRequestModel(
    garageId: json["GarageId"] == null ? null : json["GarageId"],
    userId: json["UserId"] == null ? null : json["UserId"],
    requestId: json["RequestId"] == null ? null : json["RequestId"],
  );

  Map<String, dynamic> toJson() => {
    "GarageId": garageId == null ? null : garageId,
    "UserId": userId == null ? null : userId,
    "RequestId": requestId == null ? null : requestId,
  };
}
