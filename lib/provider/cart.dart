import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imgUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imgUrl,
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

  void addItem(String prodId, String title, double price, String imgUrl) {
    if (_items.containsKey(prodId)) {
      //Update quantity
      _items.update(
          prodId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                imgUrl: existingCartItem.imgUrl,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                imgUrl: imgUrl,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }

  void removeSingleItem(String prodId) {
    if (!items.containsKey(prodId)) return;
    if (_items[prodId]!.quantity > 1) {
      _items.update(
        prodId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          price: value.price,
          imgUrl: value.imgUrl,
          quantity: value.quantity - 1,
        ),
      );
    } else {
      _items.remove(prodId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
