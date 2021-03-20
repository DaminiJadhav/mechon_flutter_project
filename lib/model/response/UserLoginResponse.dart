// To parse this JSON data, do
//
//     final userLoginResponse = userLoginResponseFromJson(jsonString);

import 'dart:convert';

UserLoginResponse userLoginResponseFromJson(String str) => UserLoginResponse.fromJson(json.decode(str));

String userLoginResponseToJson(UserLoginResponse data) => json.encode(data.toJson());

class UserLoginResponse {
  UserLoginResponse({
    this.status,
    this.message,
    this.response,
  });

  int status;
  String message;
  Response response;

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) => UserLoginResponse(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    response: json["Response"] == null ? null : Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "Response": response == null ? null : response.toJson(),
  };
}

class Response {
  Response({
    this.aspNetUserClaims,
    this.aspNetUserLogins,
    this.aspNetRoles,
    this.id,
    this.email,
    this.emailConfirmed,
    this.passwordHash,
    this.securityStamp,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.twoFactorEnabled,
    this.lockoutEndDateUtc,
    this.lockoutEnabled,
    this.accessFailedCount,
    this.userName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.mobNo,
    this.dob,
    this.userFcmTocken,
  });

  List<dynamic> aspNetUserClaims;
  List<dynamic> aspNetUserLogins;
  List<dynamic> aspNetRoles;
  String id;
  String email;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  dynamic phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  dynamic lockoutEndDateUtc;
  bool lockoutEnabled;
  int accessFailedCount;
  String userName;
  String firstName;
  String middleName;
  String lastName;
  String mobNo;
  dynamic dob;
  String userFcmTocken;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    aspNetUserClaims: json["AspNetUserClaims"] == null ? null : List<dynamic>.from(json["AspNetUserClaims"].map((x) => x)),
    aspNetUserLogins: json["AspNetUserLogins"] == null ? null : List<dynamic>.from(json["AspNetUserLogins"].map((x) => x)),
    aspNetRoles: json["AspNetRoles"] == null ? null : List<dynamic>.from(json["AspNetRoles"].map((x) => x)),
    id: json["Id"] == null ? null : json["Id"],
    email: json["Email"] == null ? null : json["Email"],
    emailConfirmed: json["EmailConfirmed"] == null ? null : json["EmailConfirmed"],
    passwordHash: json["PasswordHash"] == null ? null : json["PasswordHash"],
    securityStamp: json["SecurityStamp"] == null ? null : json["SecurityStamp"],
    phoneNumber: json["PhoneNumber"],
    phoneNumberConfirmed: json["PhoneNumberConfirmed"] == null ? null : json["PhoneNumberConfirmed"],
    twoFactorEnabled: json["TwoFactorEnabled"] == null ? null : json["TwoFactorEnabled"],
    lockoutEndDateUtc: json["LockoutEndDateUtc"],
    lockoutEnabled: json["LockoutEnabled"] == null ? null : json["LockoutEnabled"],
    accessFailedCount: json["AccessFailedCount"] == null ? null : json["AccessFailedCount"],
    userName: json["UserName"] == null ? null : json["UserName"],
    firstName: json["FirstName"] == null ? null : json["FirstName"],
    middleName: json["MiddleName"] == null ? null : json["MiddleName"],
    lastName: json["LastName"] == null ? null : json["LastName"],
    mobNo: json["MobNo"] == null ? null : json["MobNo"],
    dob: json["DOB"],
    userFcmTocken: json["UserFCMTocken"] == null ? null : json["UserFCMTocken"],
  );

  Map<String, dynamic> toJson() => {
    "AspNetUserClaims": aspNetUserClaims == null ? null : List<dynamic>.from(aspNetUserClaims.map((x) => x)),
    "AspNetUserLogins": aspNetUserLogins == null ? null : List<dynamic>.from(aspNetUserLogins.map((x) => x)),
    "AspNetRoles": aspNetRoles == null ? null : List<dynamic>.from(aspNetRoles.map((x) => x)),
    "Id": id == null ? null : id,
    "Email": email == null ? null : email,
    "EmailConfirmed": emailConfirmed == null ? null : emailConfirmed,
    "PasswordHash": passwordHash == null ? null : passwordHash,
    "SecurityStamp": securityStamp == null ? null : securityStamp,
    "PhoneNumber": phoneNumber,
    "PhoneNumberConfirmed": phoneNumberConfirmed == null ? null : phoneNumberConfirmed,
    "TwoFactorEnabled": twoFactorEnabled == null ? null : twoFactorEnabled,
    "LockoutEndDateUtc": lockoutEndDateUtc,
    "LockoutEnabled": lockoutEnabled == null ? null : lockoutEnabled,
    "AccessFailedCount": accessFailedCount == null ? null : accessFailedCount,
    "UserName": userName == null ? null : userName,
    "FirstName": firstName == null ? null : firstName,
    "MiddleName": middleName == null ? null : middleName,
    "LastName": lastName == null ? null : lastName,
    "MobNo": mobNo == null ? null : mobNo,
    "DOB": dob,
    "UserFCMTocken": userFcmTocken == null ? null : userFcmTocken,
  };
}
