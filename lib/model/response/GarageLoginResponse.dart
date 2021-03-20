// To parse this JSON data, do
//
//     final garageLoginResponse = garageLoginResponseFromJson(jsonString);

import 'dart:convert';

GarageLoginResponse garageLoginResponseFromJson(String str) => GarageLoginResponse.fromJson(json.decode(str));

String garageLoginResponseToJson(GarageLoginResponse data) => json.encode(data.toJson());

class GarageLoginResponse {
  GarageLoginResponse({
    this.status,
    this.message,
    this.garage,
  });

  int status;
  String message;
  Garage garage;

  factory GarageLoginResponse.fromJson(Map<String, dynamic> json) => GarageLoginResponse(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    garage: json["Garage"] == null ? null : Garage.fromJson(json["Garage"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "Garage": garage == null ? null : garage.toJson(),
  };
}

class Garage {
  Garage({
    this.tblAssignProblemToUserHeader,
    this.tblGarageAndVehicleTypeMappings,
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
  });

  dynamic tblAssignProblemToUserHeader;
  List<dynamic> tblGarageAndVehicleTypeMappings;
  int garageRegistrationId;
  String garageName;
  String garageOwnerName;
  String garageOwnerMobNo;
  String garageOwnerEmail;
  String garageAddress;
  String password;
  double garageLatitude;
  double garageLongitude;
  dynamic noOfMechanics;
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
  dynamic gstNo;

  factory Garage.fromJson(Map<String, dynamic> json) => Garage(
    tblAssignProblemToUserHeader: json["tblAssignProblemToUserHeader"],
    tblGarageAndVehicleTypeMappings: json["tblGarageAndVehicleTypeMappings"] == null ? null : List<dynamic>.from(json["tblGarageAndVehicleTypeMappings"].map((x) => x)),
    garageRegistrationId: json["GarageRegistrationId"] == null ? null : json["GarageRegistrationId"],
    garageName: json["GarageName"] == null ? null : json["GarageName"],
    garageOwnerName: json["GarageOwnerName"] == null ? null : json["GarageOwnerName"],
    garageOwnerMobNo: json["GarageOwnerMobNo"] == null ? null : json["GarageOwnerMobNo"],
    garageOwnerEmail: json["GarageOwnerEmail"] == null ? null : json["GarageOwnerEmail"],
    garageAddress: json["GarageAddress"] == null ? null : json["GarageAddress"],
    password: json["Password"] == null ? null : json["Password"],
    garageLatitude: json["GarageLatitude"] == null ? null : json["GarageLatitude"].toDouble(),
    garageLongitude: json["GarageLongitude"] == null ? null : json["GarageLongitude"].toDouble(),
    noOfMechanics: json["NoOfMechanics"],
    headMechanicName: json["HeadMechanicName"] == null ? null : json["HeadMechanicName"],
    headMechanicMobNo: json["HeadMechanicMobNo"] == null ? null : json["HeadMechanicMobNo"],
    bankName: json["BankName"] == null ? null : json["BankName"],
    accountNo: json["AccountNo"] == null ? null : json["AccountNo"],
    ifscCode: json["IFSCCode"] == null ? null : json["IFSCCode"],
    upiPaymentId: json["UPIPaymentId"] == null ? null : json["UPIPaymentId"],
    upiPaymentNo: json["UPIPaymentNo"] == null ? null : json["UPIPaymentNo"],
    isActive: json["IsActive"] == null ? null : json["IsActive"],
    userId: json["UserId"] == null ? null : json["UserId"],
    requestId: json["RequestId"] == null ? null : json["RequestId"],
    garageFcmTocken: json["GarageFCMTocken"] == null ? null : json["GarageFCMTocken"],
    gstNo: json["GSTNo"],
  );

  Map<String, dynamic> toJson() => {
    "tblAssignProblemToUserHeader": tblAssignProblemToUserHeader,
    "tblGarageAndVehicleTypeMappings": tblGarageAndVehicleTypeMappings == null ? null : List<dynamic>.from(tblGarageAndVehicleTypeMappings.map((x) => x)),
    "GarageRegistrationId": garageRegistrationId == null ? null : garageRegistrationId,
    "GarageName": garageName == null ? null : garageName,
    "GarageOwnerName": garageOwnerName == null ? null : garageOwnerName,
    "GarageOwnerMobNo": garageOwnerMobNo == null ? null : garageOwnerMobNo,
    "GarageOwnerEmail": garageOwnerEmail == null ? null : garageOwnerEmail,
    "GarageAddress": garageAddress == null ? null : garageAddress,
    "Password": password == null ? null : password,
    "GarageLatitude": garageLatitude == null ? null : garageLatitude,
    "GarageLongitude": garageLongitude == null ? null : garageLongitude,
    "NoOfMechanics": noOfMechanics,
    "HeadMechanicName": headMechanicName == null ? null : headMechanicName,
    "HeadMechanicMobNo": headMechanicMobNo == null ? null : headMechanicMobNo,
    "BankName": bankName == null ? null : bankName,
    "AccountNo": accountNo == null ? null : accountNo,
    "IFSCCode": ifscCode == null ? null : ifscCode,
    "UPIPaymentId": upiPaymentId == null ? null : upiPaymentId,
    "UPIPaymentNo": upiPaymentNo == null ? null : upiPaymentNo,
    "IsActive": isActive == null ? null : isActive,
    "UserId": userId == null ? null : userId,
    "RequestId": requestId == null ? null : requestId,
    "GarageFCMTocken": garageFcmTocken == null ? null : garageFcmTocken,
    "GSTNo": gstNo,
  };
}
