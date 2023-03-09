// To parse this JSON data, do
//
//     final terjualModelStok = terjualModelStokFromJson(jsonString);

import 'dart:convert';

TerjualModelStok terjualModelStokFromJson(String str) => TerjualModelStok.fromJson(json.decode(str));

String terjualModelStokToJson(TerjualModelStok data) => json.encode(data.toJson());

class TerjualModelStok {
    TerjualModelStok({
        this.meta,
        this.data,
    });

    Meta? meta;
    Data? data;

    factory TerjualModelStok.fromJson(Map<String, dynamic> json) => TerjualModelStok(
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
        this.terjual,
        this.createdAt,
        this.updatedAt,
        this.product,
    });

    int? id;
    String? productId;
    int? terjual;
    String? createdAt;
    String? updatedAt;
    Product? product;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productId: json["product_id"],
        terjual: json["terjual"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "terjual": terjual,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "product": product?.toJson(),
    };
}

class Product {
    Product({
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

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
