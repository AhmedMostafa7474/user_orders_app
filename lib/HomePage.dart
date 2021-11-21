import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_orders_app/Controllers/OrderController.dart';
import 'package:user_orders_app/Controllers/OrderStatusController.dart';
import 'package:user_orders_app/GraphPage.dart';
import 'package:user_orders_app/Models/OrderGraph.dart';
import 'package:user_orders_app/Models/OrderStatus.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'Controllers/OrderGraphController.dart';
import 'Models/Order.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  late Future myFuture;
  List<Order> items=[];
  OrderStatusController _controller = Get.put(OrderStatusController());
  OrderGraphController _controller2 = Get.put(OrderGraphController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //myFuture = readJson();
    asyncInitState();

  }
  void asyncInitState() async {
    items=await readJson();
    Calc2(items);
    calc(items);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders State"),
      ),
       body:
             SingleChildScrollView(
              child: Column(
                children: [
                 Container(
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width ,
                        child:  Obx(()=>
                      DataTable(columnSpacing: 30.0,rows:
                       [
                      DataRow(cells:[
                          DataCell(Text( _controller.OrdersStatus[0].total_count.toString())),
                          DataCell(Text( _controller.OrdersStatus[0].average_price.toStringAsFixed(3))),
                          DataCell(Text( _controller.OrdersStatus[0].number_of_return.toString())),
          ])],
                        columns: [
                          DataColumn(label: Text("Total count", style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text("Average price", style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text("Number of returns", style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)))
                        ],

                      ),
                    )),
                  Center(
                    child: SizedBox(
                      height: 60,
                      width: 200,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue
                        ),
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>graphPage(_controller2)));
                        },
                        child: Text("Show Graph"
                            ,style: TextStyle(
                            color: Colors.white
                          ),
                        ),

                      ),
                    ),
                  )
                ],
              ),
            )
    );
  }
  void Calc2(List<Order>items) {
    print(items.length);
    double avg;
    double sum=0;
  int number_of_return=0;
    for(int i=0; i<items.length;i++) {
      sum=sum+double.parse(items[i].price.replaceAll(r"$", "").replaceAll(",",""));
      if (items[i].status == "RETURNED") {
        number_of_return = number_of_return+ 1;
      }
    }
    avg=sum/items.length;
    _controller.OrdersStatus.add(orderstatus("1", items.length, avg, number_of_return, 1));
  }
  void calc(List<Order>items)
  {
    for(int i=0; i<items.length;i++) {
      bool flag=false;
      if(_controller2.OrderGraph.isNotEmpty){
        for(int j=0;j<_controller2.OrderGraph.length;j++)
          {
              if(items[i].registered.split("-")[1]==_controller2.OrderGraph[j].month)
                {
                  flag=true;
                  _controller2.OrderGraph[j].orders=_controller2.OrderGraph[j].orders+1;
                }
          }
      }
      if(flag==false)
        {
          _controller2.OrderGraph.add(orderGraph(items[i].registered.split("-")[1], 1, charts.ColorUtil.fromDartColor(Colors.green)));
        }
    }
    _controller2.OrderGraph.sort((a,b)=>a.month.compareTo(b.month));
  }
}
