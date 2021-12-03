import 'package:flutter/material.dart';

import '/dummy_data/dummy_data.dart';
import '/widgets/product_item.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ebuy'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: products.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: 1 / 1.2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (ctx, i) => ProductItem(
          id: products[i].id,
          title: products[i].title,
          imgURL: products[i].imgURL,
        ),
      ),
    );
  }
}
