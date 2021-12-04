import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String desc;
  final double price;
  final String imgURL;
  bool isFav = false;

  Product({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.imgURL,
  });

  void toggleFavStatus() {
    isFav = !isFav;
    notifyListeners();
  }
}
