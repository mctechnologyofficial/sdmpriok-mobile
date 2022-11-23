// To parse this JSON data, do
//
//     final responseDetailEmployee = responseDetailEmployeeFromJson(jsonString);

import 'dart:convert';

ResponseDetailEmployee responseDetailEmployeeFromJson(String str) => ResponseDetailEmployee.fromJson(json.decode(str));

String responseDetailEmployeeToJson(ResponseDetailEmployee data) => json.encode(data.toJson());

class ResponseDetailEmployee {
  ResponseDetailEmployee({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  Data data;

  factory ResponseDetailEmployee.fromJson(Map<String, dynamic> json) => ResponseDetailEmployee(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.nip,
    required this.name,
    required this.email,
    required this.phone,
    required this.teamId,
    required this.image,
    required this.hash,
    required this.teams,
    required this.roles,
  });

  String nip;
  String name;
  String email;
  String phone;
  String teamId;
  String image;
  String hash;
  Teams teams;
  List<Role> roles;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nip: json["nip"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    teamId: json["team_id"],
    image: json["image"],
    hash: json["hash"],
    teams: Teams.fromJson(json["teams"]),
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nip": nip,
    "name": name,
    "email": email,
    "phone": phone,
    "team_id": teamId,
    "image": image,
    "hash": hash,
    "teams": teams.toJson(),
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int id;
  String name;
  String guardName;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  Pivot({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  String modelId;
  String roleId;
  String modelType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelId: json["model_id"],
    roleId: json["role_id"],
    modelType: json["model_type"],
  );

  Map<String, dynamic> toJson() => {
    "model_id": modelId,
    "role_id": roleId,
    "model_type": modelType,
  };
}

class Teams {
  Teams({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
