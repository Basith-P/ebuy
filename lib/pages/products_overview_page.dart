import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ebuy',
          style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: const ProductsGrid(),
    );
  }
}
