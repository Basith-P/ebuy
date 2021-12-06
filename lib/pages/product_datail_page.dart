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
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: loadedProduct.id,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 300,
                child: Image.network(loadedProduct.imgURL),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loadedProduct.title,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'Anton',
                          color: Colors.blueGrey[900],
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rs. ${loadedProduct.price.toString()}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    loadedProduct.desc,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
