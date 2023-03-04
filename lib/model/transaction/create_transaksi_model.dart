// To parse this JSON data, do
//
//     final createTransaksiModel = createTransaksiModelFromJson(jsonString);

import 'dart:convert';

CreateTransaksiModel createTransaksiModelFromJson(String str) => CreateTransaksiModel.fromJson(json.decode(str));

String createTransaksiModelToJson(CreateTransaksiModel data) => json.encode(data.toJson());

class CreateTransaksiModel {
    CreateTransaksiModel({
        this.meta,
        this.data,
    });

    Meta? meta;
    DataTransaksi? data;

    factory CreateTransaksiModel.fromJson(Map<String, dynamic> json) => CreateTransaksiModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : DataTransaksi.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
    };
}

class DataTransaksi {
    DataTransaksi({
        this.idTransaksi,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String? idTransaksi;
    String? status;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory DataTransaksi.fromJson(Map<String, dynamic> json) => DataTransaksi(
        idTransaksi: json["id_transaksi"],
        status: json["status"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
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
