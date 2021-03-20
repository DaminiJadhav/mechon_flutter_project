import 'dart:convert';

RejectUserRequestResponse rejectUserRequestResponseFromJson(String str) => RejectUserRequestResponse.fromJson(json.decode(str));

String rejectUserRequestResponseToJson(RejectUserRequestResponse data) => json.encode(data.toJson());

class RejectUserRequestResponse {
  RejectUserRequestResponse({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory RejectUserRequestResponse.fromJson(Map<String, dynamic> json) => RejectUserRequestResponse(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
  };
}
