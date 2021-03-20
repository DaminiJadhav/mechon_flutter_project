// To parse this JSON data, do
//
//     final garageUserIssueDetailResponse = garageUserIssueDetailResponseFromJson(jsonString);

import 'dart:convert';

GetGarageUserAcceptedRequestResponse getGarageUserAcceptedRequestResponseFromJson(String str) => GetGarageUserAcceptedRequestResponse.fromJson(json.decode(str));

String getGarageUserAcceptedRequestResponseToJson(GetGarageUserAcceptedRequestResponse data) => json.encode(data.toJson());

class GetGarageUserAcceptedRequestResponse {
  GetGarageUserAcceptedRequestResponse({
    this.status,
    this.message,
    this.userGarageIssueRequest,
  });

  int status;
  String message;
  List<UserGarageIssueRequest> userGarageIssueRequest;

  factory GetGarageUserAcceptedRequestResponse.fromJson(Map<String, dynamic> json) => GetGarageUserAcceptedRequestResponse(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    userGarageIssueRequest: json["UserGarageIssueRequest"] == null ? null : List<UserGarageIssueRequest>.from(json["UserGarageIssueRequest"].map((x) => UserGarageIssueRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "UserGarageIssueRequest": userGarageIssueRequest == null ? null : List<dynamic>.from(userGarageIssueRequest.map((x) => x.toJson())),
  };
}

class UserGarageIssueRequest {
  UserGarageIssueRequest({
    this.assignProblemToUserDetailList,
    this.assignProblemToUserId,
    this.userId,
    this.userLatitude,
    this.userLongitude,
    this.currentDateTime,
    this.endDateTime,
    this.userAddress,
    this.vehicleNo,
    this.vehicleTypeId,
    this.garageRegId,
    this.aspNetUser,
    this.tblVehicleType,
    this.other,
    this.description,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.mobNo,
    this.problemId,
    this.problem,
  });

  List<AssignProblemToUserDetailList> assignProblemToUserDetailList;
  int assignProblemToUserId;
  String userId;
  double userLatitude;
  double userLongitude;
  String currentDateTime;
  String endDateTime;
  String userAddress;
  String vehicleNo;
  dynamic vehicleTypeId;
  dynamic garageRegId;
  dynamic aspNetUser;
  dynamic tblVehicleType;
  String other;
  String description;
  String firstName;
  String lastName;
  String vehicleType;
  String mobNo;
  dynamic problemId;
  dynamic problem;

  factory UserGarageIssueRequest.fromJson(Map<String, dynamic> json) => UserGarageIssueRequest(
    assignProblemToUserDetailList: json["AssignProblemToUserDetailList"] == null ? null : List<AssignProblemToUserDetailList>.from(json["AssignProblemToUserDetailList"].map((x) => AssignProblemToUserDetailList.fromJson(x))),
    assignProblemToUserId: json["AssignProblemToUserId"] == null ? null : json["AssignProblemToUserId"],
    userId: json["UserId"] == null ? null : json["UserId"],
    userLatitude: json["UserLatitude"] == null ? null : json["UserLatitude"].toDouble(),
    userLongitude: json["UserLongitude"] == null ? null : json["UserLongitude"].toDouble(),
    currentDateTime: json["CurrentDateTime"] == null ? null : json["CurrentDateTime"],
    endDateTime: json["EndDateTime"] == null ? null : json["EndDateTime"],
    userAddress: json["UserAddress"] == null ? null : json["UserAddress"],
    vehicleNo: json["VehicleNo"] == null ? null : json["VehicleNo"],
    vehicleTypeId: json["VehicleTypeId"],
    garageRegId: json["GarageRegId"],
    aspNetUser: json["AspNetUser"],
    tblVehicleType: json["tblVehicleType"],
    other: json["Other"] == null ? null : json["Other"],
    description: json["Description"] == null ? null : json["Description"],
    firstName: json["FirstName"] == null ? null : json["FirstName"],
    lastName: json["LastName"] == null ? null : json["LastName"],
    vehicleType: json["VehicleType"] == null ? null : json["VehicleType"],
    mobNo: json["MobNo"] == null ? null : json["MobNo"],
    problemId: json["ProblemId"],
    problem: json["Problem"],
  );

  Map<String, dynamic> toJson() => {
    "AssignProblemToUserDetailList": assignProblemToUserDetailList == null ? null : List<dynamic>.from(assignProblemToUserDetailList.map((x) => x.toJson())),
    "AssignProblemToUserId": assignProblemToUserId == null ? null : assignProblemToUserId,
    "UserId": userId == null ? null : userId,
    "UserLatitude": userLatitude == null ? null : userLatitude,
    "UserLongitude": userLongitude == null ? null : userLongitude,
    "CurrentDateTime": currentDateTime == null ? null : currentDateTime,
    "EndDateTime": endDateTime == null ? null : endDateTime,
    "UserAddress": userAddress == null ? null : userAddress,
    "VehicleNo": vehicleNo == null ? null : vehicleNo,
    "VehicleTypeId": vehicleTypeId,
    "GarageRegId": garageRegId,
    "AspNetUser": aspNetUser,
    "tblVehicleType": tblVehicleType,
    "Other": other == null ? null : other,
    "Description": description == null ? null : description,
    "FirstName": firstName == null ? null : firstName,
    "LastName": lastName == null ? null : lastName,
    "VehicleType": vehicleType == null ? null : vehicleType,
    "MobNo": mobNo == null ? null : mobNo,
    "ProblemId": problemId,
    "Problem": problem,
  };
}

class AssignProblemToUserDetailList {
  AssignProblemToUserDetailList({
    this.tblAssignProblemToUserHeader,
    this.tblProblemMaster,
    this.assignProblemToUserDetailId,
    this.assignProblemToUserHeaderId,
    this.problemId,
    this.other,
  });

  dynamic tblAssignProblemToUserHeader;
  dynamic tblProblemMaster;
  int assignProblemToUserDetailId;
  int assignProblemToUserHeaderId;
  int problemId;
  String other;

  factory AssignProblemToUserDetailList.fromJson(Map<String, dynamic> json) => AssignProblemToUserDetailList(
    tblAssignProblemToUserHeader: json["tblAssignProblemToUserHeader"],
    tblProblemMaster: json["tblProblemMaster"],
    assignProblemToUserDetailId: json["AssignProblemToUserDetailId"] == null ? null : json["AssignProblemToUserDetailId"],
    assignProblemToUserHeaderId: json["AssignProblemToUserHeaderId"] == null ? null : json["AssignProblemToUserHeaderId"],
    problemId: json["ProblemId"] == null ? null : json["ProblemId"],
    other: json["Other"] == null ? null : json["Other"],
  );

  Map<String, dynamic> toJson() => {
    "tblAssignProblemToUserHeader": tblAssignProblemToUserHeader,
    "tblProblemMaster": tblProblemMaster,
    "AssignProblemToUserDetailId": assignProblemToUserDetailId == null ? null : assignProblemToUserDetailId,
    "AssignProblemToUserHeaderId": assignProblemToUserHeaderId == null ? null : assignProblemToUserHeaderId,
    "ProblemId": problemId == null ? null : problemId,
    "Other": other == null ? null : other,
  };
}
