import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) => ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    required this.code,
    required this.status,
    required this.message,
    required this.token,
  });

  int code;
  bool status;
  String message;
  String token;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "token": token,
  };
}
