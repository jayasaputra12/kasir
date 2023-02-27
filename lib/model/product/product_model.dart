// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.meta,
    this.data,
  });

  Meta? meta;
  DataProduct? data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : DataProduct.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
      };
}

class DataProduct {
  DataProduct({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory DataProduct.fromJson(Map<String, dynamic> json) => DataProduct(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
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
    this.category,
    this.stock,
    this.penjualan,
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
  Category? category;
  List<Penjualan>? stock;
  List<Penjualan>? penjualan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        stock: json["stock"] == null
            ? []
            : List<Penjualan>.from(
                json["stock"]!.map((x) => Penjualan.fromJson(x))),
        penjualan: json["penjualan"] == null
            ? []
            : List<Penjualan>.from(
                json["penjualan"]!.map((x) => Penjualan.fromJson(x))),
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
        "category": category?.toJson(),
        "stock": stock == null
            ? []
            : List<dynamic>.from(stock!.map((x) => x.toJson())),
        "penjualan": penjualan == null
            ? []
            : List<dynamic>.from(penjualan!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

class Penjualan {
  Penjualan({
    this.id,
    this.productId,
    this.terjual,
    this.createdAt,
    this.updatedAt,
    this.quantity,
  });

  int? id;
  String? productId;
  String? terjual;
  String? createdAt;
  String? updatedAt;
  String? quantity;

  factory Penjualan.fromJson(Map<String, dynamic> json) => Penjualan(
        id: json["id"],
        productId: json["product_id"],
        terjual: json["terjual"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "terjual": terjual,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "quantity": quantity,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
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
