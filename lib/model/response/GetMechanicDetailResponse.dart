// To parse this JSON data, do
//
//     final getMechanicDetailResponse = getMechanicDetailResponseFromJson(jsonString);

import 'dart:convert';

GetMechanicDetailResponse getMechanicDetailResponseFromJson(String str) => GetMechanicDetailResponse.fromJson(json.decode(str));

String getMechanicDetailResponseToJson(GetMechanicDetailResponse data) => json.encode(data.toJson());

class GetMechanicDetailResponse {
  GetMechanicDetailResponse({
    this.status,
    this.message,
    this.mechanicDetails,
  });

  int status;
  String message;
  List<MechanicDetail> mechanicDetails;

  factory GetMechanicDetailResponse.fromJson(Map<String, dynamic> json) => GetMechanicDetailResponse(
    status: json["Status"],
    message: json["Message"],
    mechanicDetails: List<MechanicDetail>.from(json["MechanicDetails"].map((x) => MechanicDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "MechanicDetails": List<dynamic>.from(mechanicDetails.map((x) => x.toJson())),
  };
}

class MechanicDetail {
  MechanicDetail({
    this.mechanicId,
    this.garageId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.mobNo,
    this.dob,
    this.imageName,
    this.imagePath,
    this.other,
    this.mechanicAndSkillMappingId,
    this.mechanicSkillId,
    this.mechanicSkillSet,
  });

  int mechanicId;
  int garageId;
  String firstName;
  String middleName;
  String lastName;
  dynamic email;
  String mobNo;
  DateTime dob;
  String imageName;
  String imagePath;
  dynamic other;
  int mechanicAndSkillMappingId;
  dynamic mechanicSkillId;
  List<MechanicSkillSet> mechanicSkillSet;

  factory MechanicDetail.fromJson(Map<String, dynamic> json) => MechanicDetail(
    mechanicId: json["MechanicId"],
    garageId: json["GarageId"],
    firstName: json["FirstName"],
    middleName: json["MiddleName"],
    lastName: json["LastName"],
    email: json["Email"],
    mobNo: json["MobNo"],
    dob: json["DOB"] == null ? null : DateTime.parse(json["DOB"]),
    imageName: json["ImageName"],
    imagePath: json["ImagePath"],
    other: json["Other"],
    mechanicAndSkillMappingId: json["MechanicAndSkillMappingId"],
    mechanicSkillId: json["MechanicSkillId"],
    mechanicSkillSet: List<MechanicSkillSet>.from(json["MechanicSkillSet"].map((x) => MechanicSkillSet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "MechanicId": mechanicId,
    "GarageId": garageId,
    "FirstName": firstName,
    "MiddleName": middleName,
    "LastName": lastName,
    "Email": email,
    "MobNo": mobNo,
    "DOB": dob == null ? null : dob.toIso8601String(),
    "ImageName": imageName,
    "ImagePath": imagePath,
    "Other": other,
    "MechanicAndSkillMappingId": mechanicAndSkillMappingId,
    "MechanicSkillId": mechanicSkillId,
    "MechanicSkillSet": List<dynamic>.from(mechanicSkillSet.map((x) => x.toJson())),
  };
}

class MechanicSkillSet {
  MechanicSkillSet({
    this.tblMechanicAndSkillMappings,
    this.skillsetId,
    this.skillName,
  });

  List<dynamic> tblMechanicAndSkillMappings;
  int skillsetId;
  String skillName;

  factory MechanicSkillSet.fromJson(Map<String, dynamic> json) => MechanicSkillSet(
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

enum SkillName { THE_4_WHEELER_BREAK, THE_3_WHEELER_OIL, THE_2_WHEELER_ENGINE }

final skillNameValues = EnumValues({
  "2 Wheeler Engine": SkillName.THE_2_WHEELER_ENGINE,
  "3 Wheeler Oil": SkillName.THE_3_WHEELER_OIL,
  "4 Wheeler Break": SkillName.THE_4_WHEELER_BREAK
});

enum MiddleName { EMPTY, GXCG }

final middleNameValues = EnumValues({
  "": MiddleName.EMPTY,
  "gxcg": MiddleName.GXCG
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}


