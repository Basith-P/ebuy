import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid(this.showFavonly);

  final bool showFavonly;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productList = showFavonly ? productsData.favItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: productList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.1,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: productList[i],
        child: const ProductItem(
            // id: productList[i].id,
            // title: productList[i].title,
            // imgURL: productList[i].imgURL,
            ),
      ),
    );
  }
}
