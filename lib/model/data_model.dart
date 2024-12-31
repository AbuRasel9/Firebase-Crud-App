// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

DataModel userModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String userModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  String? name;
  String? id;
  String? email;
  String? address;

  DataModel({
    this.name,
    this.email,
    this.address,
    this.id,
  });

  factory DataModel.fromJson(Map<String, dynamic> json,) => DataModel(
    name: json["name"],
    email: json["email"],
    address: json["address"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "address": address,
    "id":id
  };
}
