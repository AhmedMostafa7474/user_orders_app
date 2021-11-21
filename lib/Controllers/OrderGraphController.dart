import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_orders_app/Models/OrderGraph.dart';

class OrderGraphController
{
  List<orderGraph>OrderGraph=[orderGraph("01", 0, charts.ColorUtil.fromDartColor(Colors.green))].obs;

  AddOrder(value)
  {
    OrderGraph.add(value);
  }
}