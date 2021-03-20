
import 'dart:convert';

VehicleTypeListResponse vehicleTypeFromJson(String str) => VehicleTypeListResponse.fromJson(json.decode(str));

String vehicleTypeToJson(VehicleTypeListResponse data) => json.encode(data.toJson());

class VehicleTypeListResponse {
  VehicleTypeListResponse({
    this.status,
    this.message,
    this.vehicleType,
  });

  int status;
  String message;
  List<VehicleType> vehicleType;

  factory VehicleTypeListResponse.fromJson(Map<String, dynamic> json) => VehicleTypeListResponse(
    status: json["Status"],
    message: json["Message"],
    vehicleType: List<VehicleType>.from(json["VehicleType"].map((x) => VehicleType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "VehicleType": List<dynamic>.from(vehicleType.map((x) => x.toJson())),
  };
}

class VehicleType {
  VehicleType({
    this.tblAssignProblemToUserHeaders,
    this.vehicleTypeId,
    this.vehicleType,
  });

  List<dynamic> tblAssignProblemToUserHeaders;
  int vehicleTypeId;
  String vehicleType;

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
    tblAssignProblemToUserHeaders: List<dynamic>.from(json["tblAssignProblemToUserHeaders"].map((x) => x)),
    vehicleTypeId: json["VehicleTypeId"],
    vehicleType: json["VehicleType"],
  );

  Map<String, dynamic> toJson() => {
    "tblAssignProblemToUserHeaders": List<dynamic>.from(tblAssignProblemToUserHeaders.map((x) => x)),
    "VehicleTypeId": vehicleTypeId,
    "VehicleType": vehicleType,
  };
}
