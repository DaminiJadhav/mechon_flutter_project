
import 'dart:convert';

PostVehicleIssueRequest postVehicleIssueRequestFromJson(String str) => PostVehicleIssueRequest.fromJson(json.decode(str));

String postVehicleIssueRequestToJson(PostVehicleIssueRequest data) => json.encode(data.toJson());

class PostVehicleIssueRequest {
  PostVehicleIssueRequest({
    this.userId,
    this.userLatitude,
    this.currentDateTime,
    this.userLongitude,
    this.userAddress,
    this.vehicleNo,
    this.vehicleTypeId,
    this.description,
    this.other,
    this.assignProblemToUserDetailList,
  });

  String userId;
  String userLatitude;
  String currentDateTime;
  String userLongitude;
  String userAddress;
  String vehicleNo;
  String vehicleTypeId;
  String description;
  String other;
  List<AssignProblemToUserDetailList> assignProblemToUserDetailList;

  factory PostVehicleIssueRequest.fromJson(Map<String, dynamic> json) => PostVehicleIssueRequest(
    userId: json["UserId"],
    userLatitude: json["UserLatitude"],
    currentDateTime: json["CurrentDateTime"],
    userLongitude: json["UserLongitude"],
    userAddress: json["UserAddress"],
    vehicleNo: json["VehicleNo"],
    vehicleTypeId: json["VehicleTypeId"],
    description: json["Description"],
    other: json["Other"],
    assignProblemToUserDetailList: List<AssignProblemToUserDetailList>.from(json["AssignProblemToUserDetailList"].map((x) => AssignProblemToUserDetailList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "UserLatitude": userLatitude,
    "CurrentDateTime": currentDateTime,
    "UserLongitude": userLongitude,
    "UserAddress": userAddress,
    "VehicleNo": vehicleNo,
    "VehicleTypeId": vehicleTypeId,
    "Description": description,
    "Other": other,
    "AssignProblemToUserDetailList": List<dynamic>.from(assignProblemToUserDetailList.map((x) => x.toJson())),
  };
}

class AssignProblemToUserDetailList {
  AssignProblemToUserDetailList({
    this.problemId,
    this.assignProblemToUserHeaderId,
  });

  int problemId;
  String assignProblemToUserHeaderId;

  factory AssignProblemToUserDetailList.fromJson(Map<String, dynamic> json) => AssignProblemToUserDetailList(
    problemId: json["ProblemId"],
    assignProblemToUserHeaderId: json["AssignProblemToUserHeaderId"],
  );

  Map<String, dynamic> toJson() => {
    "ProblemId": problemId,
    "AssignProblemToUserHeaderId": assignProblemToUserHeaderId,
  };
}
