import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    const url = 'https://ebuy-007-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(Uri.parse(url));
    final List<OrderItem> _loadedOrders = [];
    var extractedData = {};
    extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (extractedData.isEmpty) return;

    extractedData.forEach((orderId, orderData) {
      _loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  quantity: e['quantity'],
                  price: e['price'],
                  imgUrl: e['imgUrl'],
                ))
            .toList(),
      ));
    });
    _orders = _loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://ebuy-007-default-rtdb.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartProducts
            .map((e) => {
                  'id': e.id,
                  'title': e.title,
                  'quantity': e.quantity,
                  'price': e.price,
                  'imgUrl': e.imgUrl,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: jsonDecode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }
}
