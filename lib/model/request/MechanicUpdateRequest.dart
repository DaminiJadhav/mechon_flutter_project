// To parse this JSON data, do
//
//     final mechanicUpdateRequest = mechanicUpdateRequestFromJson(jsonString);

import 'dart:convert';

MechanicUpdateRequest mechanicUpdateRequestFromJson(String str) => MechanicUpdateRequest.fromJson(json.decode(str));

String mechanicUpdateRequestToJson(MechanicUpdateRequest data) => json.encode(data.toJson());

class MechanicUpdateRequest {
  MechanicUpdateRequest({
    this.mechanicId,
    this.garageid,
    this.firstname,
    this.middlename,
    this.lastname,
    this.emailid,
    this.dob,
    this.mobNo,
    this.imageName,
    this.imagePath,
    this.other,
    this.mechanicAndSkillMappingId,
    this.mechanicSkillSet,
  });

  int mechanicId;
  int garageid;
  String firstname;
  String middlename;
  String lastname;
  String emailid;
  String dob;
  String mobNo;
  String imageName;
  String imagePath;
  String other;
  int mechanicAndSkillMappingId;
  List<MechanicSkillSet> mechanicSkillSet;

  factory MechanicUpdateRequest.fromJson(Map<String, dynamic> json) => MechanicUpdateRequest(
    mechanicId: json["MechanicId"],
    garageid: json["garageid"],
    firstname: json["firstname"],
    middlename: json["middlename"],
    lastname: json["lastname"],
    emailid: json["emailid"],
    dob: json["dob"],
    mobNo: json["MobNo"],
    imageName: json["ImageName"],
    imagePath: json["ImagePath"],
    other: json["Other"],
    mechanicAndSkillMappingId: json["MechanicAndSkillMappingId"],
    mechanicSkillSet: List<MechanicSkillSet>.from(json["MechanicSkillSet"].map((x) => MechanicSkillSet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "MechanicId": mechanicId,
    "garageid": garageid,
    "firstname": firstname,
    "middlename": middlename,
    "lastname": lastname,
    "emailid": emailid,
    "dob": dob,
    "MobNo": mobNo,
    "ImageName": imageName,
    "ImagePath": imagePath,
    "Other": other,
    "MechanicAndSkillMappingId": mechanicAndSkillMappingId,
    "MechanicSkillSet": List<dynamic>.from(mechanicSkillSet.map((x) => x.toJson())),
  };
}

class MechanicSkillSet {
  MechanicSkillSet({
    this.skillsetId,
    this.skillName,
  });

  int skillsetId;
  String skillName;

  factory MechanicSkillSet.fromJson(Map<String, dynamic> json) => MechanicSkillSet(
    skillsetId: json["SkillsetId"],
    skillName: json["SkillName"],
  );

  Map<String, dynamic> toJson() => {
    "SkillsetId": skillsetId,
    "SkillName": skillName,
  };
}
