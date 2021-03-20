
import 'dart:convert';

VehicleIssueResponse vehicleIssueResponseFromJson(String str) => VehicleIssueResponse.fromJson(json.decode(str));

String vehicleIssueResponseToJson(VehicleIssueResponse data) => json.encode(data.toJson());

class VehicleIssueResponse {
  VehicleIssueResponse({
    this.status,
    this.message,
    this.vehicleType,
  });

  int status;
  String message;
  List<VehicleIssueType> vehicleType;

  factory VehicleIssueResponse.fromJson(Map<String, dynamic> json) => VehicleIssueResponse(
    status: json["Status"],
    message: json["Message"],
    vehicleType: List<VehicleIssueType>.from(json["VehicleType"].map((x) => VehicleIssueType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "VehicleType": List<dynamic>.from(vehicleType.map((x) => x.toJson())),
  };
}

class VehicleIssueType {
  VehicleIssueType({
    this.tblAssignProblemToUserDetails,
    this.problemId,
    this.peoblem,
  });

  List<dynamic> tblAssignProblemToUserDetails;
  int problemId;
  String peoblem;

  factory VehicleIssueType.fromJson(Map<String, dynamic> json) => VehicleIssueType(
    tblAssignProblemToUserDetails: List<dynamic>.from(json["tblAssignProblemToUserDetails"].map((x) => x)),
    problemId: json["ProblemId"],
    peoblem: json["Peoblem"],
  );

  Map<String, dynamic> toJson() => {
    "tblAssignProblemToUserDetails": List<dynamic>.from(tblAssignProblemToUserDetails.map((x) => x)),
    "ProblemId": problemId,
    "Peoblem": peoblem,
  };
}
