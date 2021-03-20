

import 'dart:convert';

UserRegistrationResponse userRegistrationResponseFromJson(String str) => UserRegistrationResponse.fromJson(json.decode(str));

String userRegistrationResponseToJson(UserRegistrationResponse data) => json.encode(data.toJson());

class UserRegistrationResponse {
  UserRegistrationResponse({
    this.status,
    this.message,
    // this.response,
  });

  dynamic status;
  String message;
  // Response response;

  factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) => UserRegistrationResponse(
    status: json["Status"],
    message: json["Message"],
    // response: Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    // "Response": response.toJson(),
  };
}

/*class Response {
  Response({
    this.UserRole,
    this.MobNo,
    this.Email,
    this.Password,
    this.UserName,
    this.FirstName,
    this.MiddleName,
    this.LastName,

  });

  dynamic UserRole;
  String MobNo;
  String Email;
  String Password;
  dynamic UserName;
  String FirstName;
  String LastName;
  String MiddleName;


  factory Response.fromJson(Map<String, dynamic> json) => Response(
    UserRole: json["UserRole"],
    MobNo: json["MobNo"],
    Email: json["Email"],
    Password: json["Password"],
    UserName: json["UserName"],
    FirstName: json["FirstName"],
    MiddleName: json["MiddleName"],
    LastName: json["LastName"],
  );

  Map<String, dynamic> toJson() => {
    "UserRole": UserRole,
    "MobNo": MobNo,
    "Email": Email,
    "Password": Password,
    "UserName": UserName,
    "FirstName": FirstName,
    "MiddleName": MiddleName,
    "LastName": LastName,
  };
}*/



