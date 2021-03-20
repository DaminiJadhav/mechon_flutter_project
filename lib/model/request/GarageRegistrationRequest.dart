// To parse this JSON data, do
//
//     final garageRegistrationRequest = garageRegistrationRequestFromJson(jsonString);

import 'dart:convert';

GarageRegistrationRequest garageRegistrationRequestFromJson(String str) => GarageRegistrationRequest.fromJson(json.decode(str));

String garageRegistrationRequestToJson(GarageRegistrationRequest data) => json.encode(data.toJson());

class GarageRegistrationRequest {
  GarageRegistrationRequest({
    this.garageRegistrationId,
    this.garageName,
    this.garageOwnerName,
    this.garageOwnerMobNo,
    this.garageOwnerEmail,
    this.garageAddress,
    this.password,
    this.garageLatitude,
    this.garageLongitude,
    this.noOfMechanics,
    this.headMechanicName,
    this.headMechanicMobNo,
    this.bankName,
    this.accountNo,
    this.ifscCode,
    this.upiPaymentId,
    this.upiPaymentNo,
    this.isActive,
    this.userId,
    this.requestId,
    this.garageFcmTocken,
    this.gstNo,
    this.garageAndVehicleTypeMappingList,
  });

  dynamic garageRegistrationId;
  String garageName;
  String garageOwnerName;
  String garageOwnerMobNo;
  String garageOwnerEmail;
  String garageAddress;
  String password;
  double garageLatitude;
  double garageLongitude;
  int noOfMechanics;
  String headMechanicName;
  String headMechanicMobNo;
  String bankName;
  String accountNo;
  String ifscCode;
  String upiPaymentId;
  String upiPaymentNo;
  bool isActive;
  String userId;
  int requestId;
  String garageFcmTocken;
  String gstNo;
  List<GarageAndVehicleTypeMappingList> garageAndVehicleTypeMappingList;

  factory GarageRegistrationRequest.fromJson(Map<String, dynamic> json) => GarageRegistrationRequest(
    garageRegistrationId: json["GarageRegistrationId"],
    garageName: json["GarageName"],
    garageOwnerName: json["GarageOwnerName"],
    garageOwnerMobNo: json["GarageOwnerMobNo"],
    garageOwnerEmail: json["GarageOwnerEmail"],
    garageAddress: json["GarageAddress"],
    password: json["Password"],
    garageLatitude: json["GarageLatitude"].toDouble(),
    garageLongitude: json["GarageLongitude"].toDouble(),
    noOfMechanics: json["NoOfMechanics"],
    headMechanicName: json["HeadMechanicName"],
    headMechanicMobNo: json["HeadMechanicMobNo"],
    bankName: json["BankName"],
    accountNo: json["AccountNo"],
    ifscCode: json["IFSCCode"],
    upiPaymentId: json["UPIPaymentId"],
    upiPaymentNo: json["UPIPaymentNo"],
    isActive: json["IsActive"],
    userId: json["UserId"],
    requestId: json["RequestId"],
    garageFcmTocken: json["GarageFCMTocken"],
    gstNo: json["GSTNo"],
    garageAndVehicleTypeMappingList: List<GarageAndVehicleTypeMappingList>.from(json["GarageAndVehicleTypeMappingList"].map((x) => GarageAndVehicleTypeMappingList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "GarageRegistrationId": garageRegistrationId,
    "GarageName": garageName,
    "GarageOwnerName": garageOwnerName,
    "GarageOwnerMobNo": garageOwnerMobNo,
    "GarageOwnerEmail": garageOwnerEmail,
    "GarageAddress": garageAddress,
    "Password": password,
    "GarageLatitude": garageLatitude,
    "GarageLongitude": garageLongitude,
    "NoOfMechanics": noOfMechanics,
    "HeadMechanicName": headMechanicName,
    "HeadMechanicMobNo": headMechanicMobNo,
    "BankName": bankName,
    "AccountNo": accountNo,
    "IFSCCode": ifscCode,
    "UPIPaymentId": upiPaymentId,
    "UPIPaymentNo": upiPaymentNo,
    "IsActive": isActive,
    "UserId": userId,
    "RequestId": requestId,
    "GarageFCMTocken": garageFcmTocken,
    "GSTNo": gstNo,
    "GarageAndVehicleTypeMappingList": List<dynamic>.from(garageAndVehicleTypeMappingList.map((x) => x.toJson())),
  };
}

class GarageAndVehicleTypeMappingList {
  GarageAndVehicleTypeMappingList({
    this.vehicleTypeId,
    this.tblVehicleType,
  });

  int vehicleTypeId;
  String tblVehicleType;

  factory GarageAndVehicleTypeMappingList.fromJson(Map<String, dynamic> json) => GarageAndVehicleTypeMappingList(
    vehicleTypeId: json["VehicleTypeId"],
    tblVehicleType: json["tblVehicleType"],
  );

  Map<String, dynamic> toJson() => {
    "VehicleTypeId": vehicleTypeId,
    "tblVehicleType": tblVehicleType,
  };
}
