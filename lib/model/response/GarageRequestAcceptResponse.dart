
import 'dart:convert';

GarageRequestAcceptResponse garageRequestAcceptResponseFromJson(String str) => GarageRequestAcceptResponse.fromJson(json.decode(str));

String garageRequestAcceptResponseToJson(GarageRequestAcceptResponse data) => json.encode(data.toJson());

class GarageRequestAcceptResponse {
  GarageRequestAcceptResponse({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory GarageRequestAcceptResponse.fromJson(Map<String, dynamic> json) => GarageRequestAcceptResponse(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
