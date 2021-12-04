import 'package:ebuy/models/model_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class ProductDetailpage extends StatelessWidget {
  final String data;

  const ProductDetailpage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = data;
    final loadedProduct = Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Container(
        child: Text(''),
      ),
    );
  }
}
