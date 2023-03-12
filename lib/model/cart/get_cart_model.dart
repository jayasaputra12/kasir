// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) =>
    GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  GetCartModel({
    this.meta,
    this.data,
  });

  Meta? meta;
  List<Datum>? data;

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.productId,
    this.userId,
    this.transaksiId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  ProductId? productId;
  UserId? userId;
  String? transaksiId;
  String? quantity;
  String? createdAt;
  String? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"] == null
            ? null
            : ProductId.fromJson(json["product_id"]),
        userId:
            json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
        transaksiId: json["transaksi_id"],
        quantity: json["quantity"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId?.toJson(),
        "user_id": userId?.toJson(),
        "transaksi_id": transaksiId,
        "quantity": quantity,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class ProductId {
  ProductId({
    this.id,
    this.categoryId,
    this.nameProduct,
    this.priceUnit,
    this.priceModal,
    this.photoProduct,
    this.description,
    this.codeUnique,
    this.photoBarcode,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? categoryId;
  String? nameProduct;
  String? priceUnit;
  String? priceModal;
  String? photoProduct;
  String? description;
  String? codeUnique;
  String? photoBarcode;
  String? createdAt;
  String? updatedAt;

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["id"],
        categoryId: json["category_id"],
        nameProduct: json["name_product"],
        priceUnit: json["price_unit"],
        priceModal: json["price_modal"],
        photoProduct: json["photo_product"],
        description: json["description"],
        codeUnique: json["code_unique"],
        photoBarcode: json["photo_barcode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name_product": nameProduct,
        "price_unit": priceUnit,
        "price_modal": priceModal,
        "photo_product": photoProduct,
        "description": description,
        "code_unique": codeUnique,
        "photo_barcode": photoBarcode,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class UserId {
  UserId({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.telp,
    this.address,
    this.avatar,
    this.cabang,
    this.priceKas,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? role;
  String? telp;
  String? address;
  String? avatar;
  dynamic cabang;
  dynamic priceKas;
  String? createdAt;
  String? updatedAt;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        role: json["role"],
        telp: json["telp"],
        address: json["address"],
        avatar: json["avatar"],
        cabang: json["cabang"],
        priceKas: json["price_kas"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role": role,
        "telp": telp,
        "address": address,
        "avatar": avatar,
        "cabang": cabang,
        "price_kas": priceKas,
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
