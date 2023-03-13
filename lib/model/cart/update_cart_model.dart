// To parse this JSON data, do
//
//     final updateCartModel = updateCartModelFromJson(jsonString);

import 'dart:convert';

UpdateCartModel updateCartModelFromJson(String str) =>
    UpdateCartModel.fromJson(json.decode(str));

String updateCartModelToJson(UpdateCartModel data) =>
    json.encode(data.toJson());

class UpdateCartModel {
  UpdateCartModel({
    this.meta,
    this.data,
  });

  Meta? meta;
  Data? data;

  factory UpdateCartModel.fromJson(Map<String, dynamic> json) =>
      UpdateCartModel(
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
  TransaksiId? transaksiId;
  String? quantity;
  String? createdAt;
  String? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productId: json["product_id"] == null
            ? null
            : ProductId.fromJson(json["product_id"]),
        userId:
            json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
        transaksiId: json["transaksi_id"] == null
            ? null
            : TransaksiId.fromJson(json["transaksi_id"]),
        quantity: json["quantity"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId?.toJson(),
        "user_id": userId?.toJson(),
        "transaksi_id": transaksiId?.toJson(),
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

class TransaksiId {
  TransaksiId({
    this.id,
    this.idTransaksi,
    this.status,
    this.imageReceipt,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? idTransaksi;
  String? status;
  String? imageReceipt;
  dynamic description;
  String? createdAt;
  String? updatedAt;

  factory TransaksiId.fromJson(Map<String, dynamic> json) => TransaksiId(
        id: json["id"],
        idTransaksi: json["id_transaksi"],
        status: json["status"],
        imageReceipt: json["image_receipt"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_transaksi": idTransaksi,
        "status": status,
        "image_receipt": imageReceipt,
        "description": description,
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
