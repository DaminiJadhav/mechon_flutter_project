import 'dart:convert';

GetNearByGarageLocationResponse getNearByGarageLocationResponseFromJson(String str) => GetNearByGarageLocationResponse.fromJson(json.decode(str));

String getNearByGarageLocationResponseToJson(GetNearByGarageLocationResponse data) => json.encode(data.toJson());

class GetNearByGarageLocationResponse {
  GetNearByGarageLocationResponse({
    this.status,
    this.message,
    this.userGarageIssueRequest,
  });

  int status;
  String message;
  List<UserGarageIssueRequest> userGarageIssueRequest;

  factory GetNearByGarageLocationResponse.fromJson(Map<String, dynamic> json) => GetNearByGarageLocationResponse(
    status: json["Status"],
    message: json["Message"],
    userGarageIssueRequest: List<UserGarageIssueRequest>.from(json["UserGarageIssueRequest"].map((x) => UserGarageIssueRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "UserGarageIssueRequest": List<dynamic>.from(userGarageIssueRequest.map((x) => x.toJson())),
  };
}

class UserGarageIssueRequest {
  UserGarageIssueRequest({
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

  int garageRegistrationId;
  String garageName;
  String garageOwnerName;
  String garageOwnerMobNo;
  String garageOwnerEmail;
  String garageAddress;
  dynamic password;
  double garageLatitude;
  double garageLongitude;
  dynamic noOfMechanics;
  dynamic headMechanicName;
  dynamic headMechanicMobNo;
  String bankName;
  String accountNo;
  String ifscCode;
  String upiPaymentId;
  String upiPaymentNo;
  bool isActive;
  String userId;
  dynamic requestId;
  String garageFcmTocken;
  String gstNo;
  dynamic garageAndVehicleTypeMappingList;

  factory UserGarageIssueRequest.fromJson(Map<String, dynamic> json) => UserGarageIssueRequest(
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
    garageAndVehicleTypeMappingList: json["GarageAndVehicleTypeMappingList"],
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
    "GarageAndVehicleTypeMappingList": garageAndVehicleTypeMappingList,
  };
}
