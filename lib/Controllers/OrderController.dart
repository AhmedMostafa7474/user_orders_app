import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:user_orders_app/Models/Order.dart';

Future<List<Order>> readJson() async {
  final String response = await rootBundle.loadString('assets/orders.json');
  final data = await json.decode(response) as List<dynamic>;
  final list= data.map((e) => Order.fromJson(e)).toList();
  return list;
}
