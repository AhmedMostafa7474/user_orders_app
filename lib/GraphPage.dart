import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_orders_app/Models/OrderGraph.dart';

import 'Controllers/OrderGraphController.dart';

class graphPage extends StatefulWidget {
  OrderGraphController _controller2;
  graphPage( this._controller2);

  @override
  _graphPageState createState() => _graphPageState(_controller2);
}

class _graphPageState extends State<graphPage> {
  OrderGraphController _controller2;
  _graphPageState(this._controller2);

  @override
  Widget build(BuildContext context) {

    List<charts.Series<orderGraph, String>> series = [
      charts.Series(
          id: "Orders",
          data: _controller2.OrderGraph,
          domainFn: (orderGraph series, _) => series.month,
          measureFn: (orderGraph series, _) => series.orders,
          colorFn: (orderGraph series, _) => series.barColor

      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders Graph"),

      ),
      body: Container(
        height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Orders by Months",
                  style: Theme.of(context).textTheme.body2,
                ),
                Expanded(
                  child: charts.BarChart(series, animate: true),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
