
import 'dart:convert';

PostVehicleIssueResponse postVehicleIssueResponseFromJson(String str) => PostVehicleIssueResponse.fromJson(json.decode(str));

String postVehicleIssueResponseToJson(PostVehicleIssueResponse data) => json.encode(data.toJson());

class PostVehicleIssueResponse {
  PostVehicleIssueResponse({
    this.status,
    this.message,
    this.requestId,
    this.garageList,
    this.notificationResponse,
  });

  int status;
  String message;
  int requestId;
  List<GarageList> garageList;
  NotificationResponse notificationResponse;

  factory PostVehicleIssueResponse.fromJson(Map<String, dynamic> json) => PostVehicleIssueResponse(
    status: json["Status"],
    message: json["Message"],
    requestId: json["RequestId"],
    garageList: List<GarageList>.from(json["GarageList"].map((x) => GarageList.fromJson(x))),
    notificationResponse: NotificationResponse.fromJson(json["NotificationResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "RequestId": requestId,
    "GarageList": List<dynamic>.from(garageList.map((x) => x.toJson())),
    "NotificationResponse": notificationResponse.toJson(),
  };
}

class GarageList {
  GarageList({
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
  dynamic requestId;
  String garageFcmTocken;
  String gstNo;

  factory GarageList.fromJson(Map<String, dynamic> json) => GarageList(
    tblAssignProblemToUserHeader: json["tblAssignProblemToUserHeader"],
    tblGarageAndVehicleTypeMappings: List<dynamic>.from(json["tblGarageAndVehicleTypeMappings"].map((x) => x)),
    garageRegistrationId: json["GarageRegistrationId"],
    garageName: json["GarageName"],
    garageOwnerName: json["GarageOwnerName"],
    garageOwnerMobNo: json["GarageOwnerMobNo"],
    garageOwnerEmail: json["GarageOwnerEmail"],
    garageAddress: json["GarageAddress"],
    password: json["Password"],
    garageLatitude: json["GarageLatitude"].toDouble(),
    garageLongitude: json["GarageLongitude"].toDouble(),
    noOfMechanics: json["NoOfMechanics"] == null ? null : json["NoOfMechanics"],
    headMechanicName: json["HeadMechanicName"] == null ? null : json["HeadMechanicName"],
    headMechanicMobNo: json["HeadMechanicMobNo"] == null ? null : json["HeadMechanicMobNo"],
    bankName: json["BankName"],
    accountNo: json["AccountNo"],
    ifscCode: json["IFSCCode"],
    upiPaymentId: json["UPIPaymentId"],
    upiPaymentNo: json["UPIPaymentNo"],
    isActive: json["IsActive"],
    userId: json["UserId"] == null ? null : json["UserId"],
    requestId: json["RequestId"],
    garageFcmTocken: json["GarageFCMTocken"],
    gstNo: json["GSTNo"] == null ? null : json["GSTNo"],
  );

  Map<String, dynamic> toJson() => {
    "tblAssignProblemToUserHeader": tblAssignProblemToUserHeader,
    "tblGarageAndVehicleTypeMappings": List<dynamic>.from(tblGarageAndVehicleTypeMappings.map((x) => x)),
    "GarageRegistrationId": garageRegistrationId,
    "GarageName": garageName,
    "GarageOwnerName": garageOwnerName,
    "GarageOwnerMobNo": garageOwnerMobNo,
    "GarageOwnerEmail": garageOwnerEmail,
    "GarageAddress": garageAddress,
    "Password": password,
    "GarageLatitude": garageLatitude,
    "GarageLongitude": garageLongitude,
    "NoOfMechanics": noOfMechanics == null ? null : noOfMechanics,
    "HeadMechanicName": headMechanicName == null ? null : headMechanicName,
    "HeadMechanicMobNo": headMechanicMobNo == null ? null : headMechanicMobNo,
    "BankName": bankName,
    "AccountNo": accountNo,
    "IFSCCode": ifscCode,
    "UPIPaymentId": upiPaymentId,
    "UPIPaymentNo": upiPaymentNo,
    "IsActive": isActive,
    "UserId": userId == null ? null : userId,
    "RequestId": requestId,
    "GarageFCMTocken": garageFcmTocken,
    "GSTNo": gstNo == null ? null : gstNo,
  };
}

class NotificationResponse {
  NotificationResponse({
    this.userId,
    this.name,
    this.requestId,
  });

  String userId;
  String name;
  int requestId;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    userId: json["UserId"],
    name: json["Name"],
    requestId: json["RequestId"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "Name": name,
    "RequestId": requestId,
  };
}
