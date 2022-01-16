import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  void toggleFavStatus() async {
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();

    final url = 'https://ebuy-007-default-rtdb.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(
        Uri.parse(url),
        body: jsonEncode({'isFav': isFav}),
      );
      if (response.statusCode >= 400) {
        isFav = oldStatus;
        notifyListeners();
      }
    } catch (e) {
      isFav = oldStatus;
      notifyListeners();
    }
  }
}
