
import 'dart:convert';

GetMechanicSkillResponse getMechanicSkillResponseFromJson(String str) => GetMechanicSkillResponse.fromJson(json.decode(str));

String getMechanicSkillResponseToJson(GetMechanicSkillResponse data) => json.encode(data.toJson());

class GetMechanicSkillResponse {
  GetMechanicSkillResponse({
    this.status,
    this.message,
    this.mechanicSkills,
  });

  int status;
  String message;
  List<MechanicSkill> mechanicSkills;

  factory GetMechanicSkillResponse.fromJson(Map<String, dynamic> json) => GetMechanicSkillResponse(
    status: json["Status"],
    message: json["Message"],
    mechanicSkills: List<MechanicSkill>.from(json["MechanicSkills"].map((x) => MechanicSkill.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "MechanicSkills": List<dynamic>.from(mechanicSkills.map((x) => x.toJson())),
  };
}

class MechanicSkill {
  MechanicSkill({
    this.tblMechanicAndSkillMappings,
    this.skillsetId,
    this.skillName,
  });

  List<dynamic> tblMechanicAndSkillMappings;
  int skillsetId;
  String skillName;

  factory MechanicSkill.fromJson(Map<String, dynamic> json) => MechanicSkill(
    tblMechanicAndSkillMappings: List<dynamic>.from(json["tblMechanicAndSkillMappings"].map((x) => x)),
    skillsetId: json["SkillsetId"],
    skillName: json["SkillName"],
  );

  Map<String, dynamic> toJson() => {
    "tblMechanicAndSkillMappings": List<dynamic>.from(tblMechanicAndSkillMappings.map((x) => x)),
    "SkillsetId": skillsetId,
    "SkillName": skillName,
  };
}
