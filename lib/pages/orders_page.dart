import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/left_drawer.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return context.read<Orders>().fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const LeftDrawer(),
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(strokeWidth: 2));
            } else {
              if (snapShot.hasError) {
                //...
                return const Center(child: Text('An error occured'));
              } else {
                return Consumer<Orders>(
                  builder: ((ctx, orderData, child) => ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, i) => OrderItem(
                          order: orderData.orders[i],
                        ),
                      )),
                );
              }
            }
          },
        ));
  }
}
