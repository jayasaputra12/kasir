// To parse this JSON data, do
//
//     final createReportPenjualan = createReportPenjualanFromJson(jsonString);

import 'dart:convert';

CreateReportPenjualan createReportPenjualanFromJson(String str) => CreateReportPenjualan.fromJson(json.decode(str));

String createReportPenjualanToJson(CreateReportPenjualan data) => json.encode(data.toJson());

class CreateReportPenjualan {
    CreateReportPenjualan({
        this.meta,
        this.data,
    });

    Meta? meta;
    Data? data;

    factory CreateReportPenjualan.fromJson(Map<String, dynamic> json) => CreateReportPenjualan(
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
        this.customerId,
        this.quantitySale,
        this.totalPrice,
        this.payment,
        this.paymentTerm,
        this.idTransaksi,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.customer,
        this.transaksi,
    });

    int? id;
    String? productId;
    dynamic customerId;
    String? quantitySale;
    String? totalPrice;
    String? payment;
    String? paymentTerm;
    String? idTransaksi;
    String? createdAt;
    String? updatedAt;
    Product? product;
    dynamic customer;
    Transaksi? transaksi;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productId: json["product_id"],
        customerId: json["customer_id"],
        quantitySale: json["quantity_sale"],
        totalPrice: json["total_price"],
        payment: json["payment"],
        paymentTerm: json["payment_term"],
        idTransaksi: json["id_transaksi"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        customer: json["customer"],
        transaksi: json["transaksi"] == null ? null : Transaksi.fromJson(json["transaksi"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "customer_id": customerId,
        "quantity_sale": quantitySale,
        "total_price": totalPrice,
        "payment": payment,
        "payment_term": paymentTerm,
        "id_transaksi": idTransaksi,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "product": product?.toJson(),
        "customer": customer,
        "transaksi": transaksi?.toJson(),
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
        this.idTransaksi,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? idTransaksi;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        idTransaksi: json["id_transaksi"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_transaksi": idTransaksi,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
