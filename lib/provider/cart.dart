import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    var count = 0;
    _items.forEach((key, value) => count += value.quantity);
    return count;
  }

  double get totalAmount {
    var totalAmount = 0.00;
    _items.forEach((key, value) => totalAmount += (value.price * value.quantity));
    return totalAmount;
  }

  void addItem(String prodId, String title, double price) {
    if (_items.containsKey(prodId)) {
      //Update quantity
      _items.update(
          prodId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }
}
