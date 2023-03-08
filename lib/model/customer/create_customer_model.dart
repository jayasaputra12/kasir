// To parse this JSON data, do
//
//     final createCustomerModel = createCustomerModelFromJson(jsonString);

import 'dart:convert';

CreateCustomerModel createCustomerModelFromJson(String str) =>
    CreateCustomerModel.fromJson(json.decode(str));

String createCustomerModelToJson(CreateCustomerModel data) =>
    json.encode(data.toJson());

class CreateCustomerModel {
  CreateCustomerModel({
    this.meta,
    this.data,
  });

  Meta? meta;
  Data? data;

  factory CreateCustomerModel.fromJson(Map<String, dynamic> json) =>
      CreateCustomerModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.nameCustomer,
    this.phone,
    this.address,
    this.photoKtp,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? nameCustomer;
  String? phone;
  String? address;
  String? photoKtp;
  String? updatedAt;
  String? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nameCustomer: json["name_customer"],
        phone: json["phone"],
        address: json["address"],
        photoKtp: json["photo_ktp"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name_customer": nameCustomer,
        "phone": phone,
        "address": address,
        "photo_ktp": photoKtp,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}

class Meta {
  Meta({
    this.code,
    this.status,
    this.message,
  });

  int? code;
  String? status;
  String? message;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };
}
