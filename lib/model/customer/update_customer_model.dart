// To parse this JSON data, do
//
//     final updateCustomerModel = updateCustomerModelFromJson(jsonString);

import 'dart:convert';

UpdateCustomerModel updateCustomerModelFromJson(String str) => UpdateCustomerModel.fromJson(json.decode(str));

String updateCustomerModelToJson(UpdateCustomerModel data) => json.encode(data.toJson());

class UpdateCustomerModel {
    UpdateCustomerModel({
        this.meta,
        this.data,
    });

    Meta? meta;
    Data? data;

    factory UpdateCustomerModel.fromJson(Map<String, dynamic> json) => UpdateCustomerModel(
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
        this.id,
        this.nameCustomer,
        this.phone,
        this.address,
        this.photoKtp,
        this.limitMoney,
        this.activate,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? nameCustomer;
    String? phone;
    String? address;
    String? photoKtp;
    String? limitMoney;
    String? activate;
    dynamic deletedAt;
    String? createdAt;
    String? updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nameCustomer: json["name_customer"],
        phone: json["phone"],
        address: json["address"],
        photoKtp: json["photo_ktp"],
        limitMoney: json["limit_money"],
        activate: json["activate"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_customer": nameCustomer,
        "phone": phone,
        "address": address,
        "photo_ktp": photoKtp,
        "limit_money": limitMoney,
        "activate": activate,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
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
