// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) => GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
    GetCartModel({
        this.meta,
        this.data,
    });

    Meta? meta;
    Data? data;

    factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
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
        productId: json["product_id"] == null ? null : ProductId.fromJson(json["product_id"]),
        userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
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
        this.penjualan,
        this.stock,
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
    List<Penjualan>? penjualan;
    List<Penjualan>? stock;

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
        penjualan: json["penjualan"] == null ? [] : List<Penjualan>.from(json["penjualan"]!.map((x) => Penjualan.fromJson(x))),
        stock: json["stock"] == null ? [] : List<Penjualan>.from(json["stock"]!.map((x) => Penjualan.fromJson(x))),
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
        "penjualan": penjualan == null ? [] : List<dynamic>.from(penjualan!.map((x) => x.toJson())),
        "stock": stock == null ? [] : List<dynamic>.from(stock!.map((x) => x.toJson())),
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
    String? cabang;
    String? priceKas;
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
