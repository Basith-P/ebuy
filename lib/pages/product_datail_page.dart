import 'package:flutter/material.dart';

class ProductDetailpage extends StatelessWidget {
  const ProductDetailpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('productId'),
      ),
      body: Container(),
    );
  }
}
