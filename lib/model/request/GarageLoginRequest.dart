import 'dart:convert';

GarageLoginRequest garageLoginRequestFromJson(String str) => GarageLoginRequest.fromJson(json.decode(str));

String garageLoginRequestToJson(GarageLoginRequest data) => json.encode(data.toJson());

class GarageLoginRequest {
  GarageLoginRequest({
    this.mobNo,
    this.password,
    this.fCMTocken,

  });

  String mobNo;
  String password;
  String fCMTocken;


  factory GarageLoginRequest.fromJson(Map<String, dynamic> json) => GarageLoginRequest(
    mobNo: json["MobNo"],
    password: json["Password"],
    fCMTocken: json["FCMTocken"],

  );

  Map<String, dynamic> toJson() => {
    "MobNo": mobNo,
    "Password": password,
    "FCMTocken": fCMTocken,


  };
}
