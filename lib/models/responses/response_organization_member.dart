import 'package:meta/meta.dart';
import 'dart:convert';

List<ResponseOrganizationMember> responseOrganizationMemberFromJson(String str) => List<ResponseOrganizationMember>.from(json.decode(str).map((x) => ResponseOrganizationMember.fromJson(x)));

String responseOrganizationMemberToJson(List<ResponseOrganizationMember> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseOrganizationMember {
  ResponseOrganizationMember({
    required this.id,
    required this.nip,
    required this.name,
    required this.email,
    required this.phone,
    required this.teamId,
    required this.image,
  });

  int id;
  String nip;
  String name;
  String email;
  String phone;
  String teamId;
  String image;

  factory ResponseOrganizationMember.fromJson(Map<String, dynamic> json) => ResponseOrganizationMember(
    id: json["id"],
    nip: json["nip"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    teamId: json["team_id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nip": nip,
    "name": name,
    "email": email,
    "phone": phone,
    "team_id": teamId,
    "image": image,
  };
}
