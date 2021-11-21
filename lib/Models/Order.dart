// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required  this.picture,
    required this.buyer,
    required this.tags,
    required  this.status,
    required  this.registered,
  });

  String id;
  bool isActive;
  String price;
  String company;
  String picture;
  String buyer;
  List<String> tags;
  String status;
  String registered;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    isActive: json["isActive"],
    price: json["price"],
    company: json["company"],
    picture: json["picture"],
    buyer: json["buyer"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    status: json["status"],
    registered: json["registered"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isActive": isActive,
    "price": price,
    "company": company,
    "picture": picture,
    "buyer": buyer,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "status": status,
    "registered": registered,
  };
}
