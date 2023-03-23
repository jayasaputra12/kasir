// To parse this JSON data, do
//
//     final getHistoryModel = getHistoryModelFromJson(jsonString);

import 'dart:convert';

GetHistoryModel getHistoryModelFromJson(String str) => GetHistoryModel.fromJson(json.decode(str));

String getHistoryModelToJson(GetHistoryModel data) => json.encode(data.toJson());

class GetHistoryModel {
    GetHistoryModel({
        this.meta,
        this.data,
    });

    Meta? meta;
    Data? data;

    factory GetHistoryModel.fromJson(Map<String, dynamic> json) => GetHistoryModel(
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
        this.invoice,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.users,
    });

    int? id;
    String? invoice;
    String? status;
    String? userId;
    String? createdAt;
    String? updatedAt;
    Users? users;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        invoice: json["invoice"],
        status: json["status"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "status": status,
        "user_id": userId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "users": users?.toJson(),
    };
}

class Users {
    Users({
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

    factory Users.fromJson(Map<String, dynamic> json) => Users(
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
