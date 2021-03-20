
import 'dart:convert';

UserRegistrationRequest userRegistrationFromJson(String str) => UserRegistrationRequest.fromJson(json.decode(str));

String userRegistrationToJson(UserRegistrationRequest data) => json.encode(data.toJson());

class UserRegistrationRequest {
  UserRegistrationRequest({
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.password,
    this.mobNo,
    this.dob,
  });

  String firstName;
  String middleName;
  String lastName;
  String email;
  String password;
  String mobNo;
  String dob;

  factory UserRegistrationRequest.fromJson(Map<String, dynamic> json) => UserRegistrationRequest(
    firstName: json["FirstName"],
    middleName: json["MiddleName"],
    lastName: json["LastName"],
    email: json["Email"],
    password: json["Password"],
    mobNo: json["MobNo"],
    dob: json["DOB"],
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName,
    "MiddleName": middleName,
    "LastName": lastName,
    "Email": email,
    "Password": password,
    "MobNo": mobNo,
    "DOB": dob,
  };
}
