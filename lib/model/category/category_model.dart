// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.meta,
    this.data,
  });

  Meta? meta;
  List<DataCategory>? data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<DataCategory>.from(
                json["data"]!.map((x) => DataCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataCategory {
  DataCategory({
    this.id,
    this.nameCategory,
    this.photoCategory,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nameCategory;
  String? photoCategory;
  String? createdAt;
  String? updatedAt;

  factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
        id: json["id"],
        nameCategory: json["name_category"],
        photoCategory: json["photo_category"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_category": nameCategory,
        "photo_category": photoCategory,
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
