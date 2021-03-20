// To parse this JSON data, do
//
//     final addMechanicDetailRequest = addMechanicDetailRequestFromJson(jsonString);

import 'dart:convert';

AddMechanicDetailRequest addMechanicDetailRequestFromJson(String str) => AddMechanicDetailRequest.fromJson(json.decode(str));

String addMechanicDetailRequestToJson(AddMechanicDetailRequest data) => json.encode(data.toJson());

class AddMechanicDetailRequest {
  AddMechanicDetailRequest({
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

  dynamic mechanicId;
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
  List<MechanicDetailSkillSet> mechanicSkillSet;

  factory AddMechanicDetailRequest.fromJson(Map<String, dynamic> json) => AddMechanicDetailRequest(
    mechanicId: json["MechanicId"],
    garageid: json["garageid"],
    firstname: json["firstname"],
    middlename: json["middlename"],
    lastname: json["lastname"],
    emailid: json["Email"],
    dob: json["dob"],
    mobNo: json["MobNo"],
    imageName: json["ImageName"],
    imagePath: json["ImagePath"],
    other: json["Other"],
    mechanicAndSkillMappingId: json["MechanicAndSkillMappingId"],
    mechanicSkillSet: List<MechanicDetailSkillSet>.from(json["MechanicSkillSet"].map((x) => MechanicDetailSkillSet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "MechanicId": mechanicId,
    "garageid": garageid,
    "firstname": firstname,
    "middlename": middlename,
    "lastname": lastname,
    "Email": emailid,
    "dob": dob,
    "MobNo": mobNo,
    "ImageName": imageName,
    "ImagePath": imagePath,
    "Other": other,
    "MechanicAndSkillMappingId": mechanicAndSkillMappingId,
    "MechanicSkillSet": List<dynamic>.from(mechanicSkillSet.map((x) => x.toJson())),
  };
}

class MechanicDetailSkillSet {
  MechanicDetailSkillSet({
    this.skillsetId,
    this.skillName,
  });

  int skillsetId;
  String skillName;

  factory MechanicDetailSkillSet.fromJson(Map<String, dynamic> json) => MechanicDetailSkillSet(
    skillsetId: json["SkillsetId"],
    skillName: json["SkillName"],
  );

  Map<String, dynamic> toJson() => {
    "SkillsetId": skillsetId,
    "SkillName": skillName,
  };
}
