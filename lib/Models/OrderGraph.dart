import 'package:charts_flutter/flutter.dart' as charts;

class orderGraph
{
  String month;
  int orders;
  final charts.Color barColor;

  orderGraph(this.month, this.orders, this.barColor);
}