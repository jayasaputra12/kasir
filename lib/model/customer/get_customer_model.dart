// To parse this JSON data, do
//
//     final getCustomerModel = getCustomerModelFromJson(jsonString);

import 'dart:convert';

GetCustomerModel getCustomerModelFromJson(String str) => GetCustomerModel.fromJson(json.decode(str));

String getCustomerModelToJson(GetCustomerModel data) => json.encode(data.toJson());

class GetCustomerModel {
    GetCustomerModel({
        this.meta,
        this.data,
    });

    Meta? meta;
    Data? data;

    factory GetCustomerModel.fromJson(Map<String, dynamic> json) => GetCustomerModel(
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
    List<DataCustomer>? data;
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
        data: json["data"] == null ? [] : List<DataCustomer>.from(json["data"]!.map((x) => DataCustomer.fromJson(x))),
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

class DataCustomer {
    DataCustomer({
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

    factory DataCustomer.fromJson(Map<String, dynamic> json) => DataCustomer(
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
