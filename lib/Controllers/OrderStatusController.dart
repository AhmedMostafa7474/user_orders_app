import 'package:get/get.dart';
import 'package:user_orders_app/Models/OrderStatus.dart';

class OrderStatusController extends GetxController
{
  RxList<dynamic>OrdersStatus=[].obs;

  AddOrder(value)
  {
    OrdersStatus.add(value);

  }
}
