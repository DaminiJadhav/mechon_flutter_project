
import 'dart:convert';

GarageRegitrationResponse garageRegistrationResponseFromJson(String str) => GarageRegitrationResponse.fromJson(json.decode(str));

String welcomeToJson(GarageRegitrationResponse data) => json.encode(data.toJson());

class GarageRegitrationResponse {
  GarageRegitrationResponse({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory GarageRegitrationResponse.fromJson(Map<String, dynamic> json) => GarageRegitrationResponse(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
