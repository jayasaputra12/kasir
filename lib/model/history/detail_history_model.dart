// To parse this JSON data, do
//
//     final detailHistoryModel = detailHistoryModelFromJson(jsonString);

import 'dart:convert';

DetailHistoryModel detailHistoryModelFromJson(String str) => DetailHistoryModel.fromJson(json.decode(str));

String detailHistoryModelToJson(DetailHistoryModel data) => json.encode(data.toJson());

class DetailHistoryModel {
    DetailHistoryModel({
        this.meta,
        this.data,
    });

    Meta? meta;
    Data? data;

    factory DetailHistoryModel.fromJson(Map<String, dynamic> json) => DetailHistoryModel(
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
    List<DataReport>? data;
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
        data: json["data"] == null ? [] : List<DataReport>.from(json["data"]!.map((x) => DataReport.fromJson(x))),
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

class DataReport {
    DataReport({
        this.id,
        this.productId,
        this.customerId,
        this.userId,
        this.idTransaksi,
        this.quantitySale,
        this.totalPrice,
        this.payment,
        this.paymentTerm,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.customer,
        this.user,
        this.transaksi,
    });

    int? id;
    String? productId;
    String? customerId;
    String? userId;
    String? idTransaksi;
    String? quantitySale;
    String? totalPrice;
    String? payment;
    DateTime? paymentTerm;
    String? createdAt;
    String? updatedAt;
    Product? product;
    Customer? customer;
    User? user;
    Transaksi? transaksi;

    factory DataReport.fromJson(Map<String, dynamic> json) => DataReport(
        id: json["id"],
        productId: json["product_id"],
        customerId: json["customer_id"],
        userId: json["user_id"],
        idTransaksi: json["id_transaksi"],
        quantitySale: json["quantity_sale"],
        totalPrice: json["total_price"],
        payment: json["payment"],
        paymentTerm: json["payment_term"] == null ? null : DateTime.parse(json["payment_term"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        transaksi: json["transaksi"] == null ? null : Transaksi.fromJson(json["transaksi"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "customer_id": customerId,
        "user_id": userId,
        "id_transaksi": idTransaksi,
        "quantity_sale": quantitySale,
        "total_price": totalPrice,
        "payment": payment,
        "payment_term": "${paymentTerm!.year.toString().padLeft(4, '0')}-${paymentTerm!.month.toString().padLeft(2, '0')}-${paymentTerm!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "updated_at": updatedAt,
        "product": product?.toJson(),
        "customer": customer?.toJson(),
        "user": user?.toJson(),
        "transaksi": transaksi?.toJson(),
    };
}

class Customer {
    Customer({
        this.id,
        this.nameCustomer,
        this.phone,
        this.address,
        this.photoKtp,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? nameCustomer;
    String? phone;
    String? address;
    String? photoKtp;
    String? createdAt;
    String? updatedAt;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        nameCustomer: json["name_customer"],
        phone: json["phone"],
        address: json["address"],
        photoKtp: json["photo_ktp"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_customer": nameCustomer,
        "phone": phone,
        "address": address,
        "photo_ktp": photoKtp,
        "created_at": createdAt,
        "updated_at": updatedAt,
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

class Transaksi {
    Transaksi({
        this.id,
        this.invoice,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? invoice;
    String? status;
    String? userId;
    String? createdAt;
    String? updatedAt;

    factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        invoice: json["invoice"],
        status: json["status"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "status": status,
        "user_id": userId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class User {
    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
