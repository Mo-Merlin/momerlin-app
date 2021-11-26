//import 'dart:ui';

class SpendingReports {
  SpendingReports({
    this.category,
    this.transactionsCount,
    this.percentage,
    this.amount,
  });

  Category category;
  int transactionsCount;
  double percentage;
  double amount;

  factory SpendingReports.fromJson(Map<String, dynamic> json) =>
      SpendingReports(
        category: Category.fromJson(json["category"]),
        transactionsCount: json["transactionsCount"],
        percentage: json["percentage"].toDouble(),
        amount: json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "transactionsCount": transactionsCount,
        "percentage": percentage,
        "amount": amount,
      };
}

class Category {
  Category({
    this.id,
    this.displayName,
    this.name,
    this.color,
    this.image,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String displayName;
  String name;
  String color;
  var image;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        displayName: json["displayName"],
        name: json["name"],
        color: json["color"],
        image: json["image"],
        active: json["active"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "displayName": displayName,
        "name": name,
        "color": color,
        "image": image,
        "active": active,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Categorytransaction {
  Categorytransaction({
    this.category,
    this.time,
    this.address,
    this.amount,
    this.createdAt,
    this.isoCurrencyCode,
    this.merchantName,
    this.name,
    this.sats,
  });

  Category category;
  DateTime time;
  String address;
  String amount;
  DateTime createdAt;
  String isoCurrencyCode;
  String merchantName;
  String name;
  var sats;

  factory Categorytransaction.fromJson(Map<String, dynamic> json) =>
      Categorytransaction(
        category: Category.fromJson(json["category"]),
        time: DateTime.parse(json["time"]),
        address: json["address"],
        amount: json["amount"],
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(num.parse(json["createdAt"])),
        isoCurrencyCode: json["iso_currency_code"],
        merchantName: json["merchant_name"],
        name: json["name"],
        sats: json["sats"],
      );
}
