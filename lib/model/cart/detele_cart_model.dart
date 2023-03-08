// To parse this JSON data, do
//
//     final deleteCartModel = deleteCartModelFromJson(jsonString);

import 'dart:convert';

DeleteCartModel deleteCartModelFromJson(String str) =>
    DeleteCartModel.fromJson(json.decode(str));

String deleteCartModelToJson(DeleteCartModel data) =>
    json.encode(data.toJson());

class DeleteCartModel {
  DeleteCartModel({
    this.meta,
    this.data,
  });

  Meta? meta;
  dynamic data;

  factory DeleteCartModel.fromJson(Map<String, dynamic> json) =>
      DeleteCartModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data,
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
