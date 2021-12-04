import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum filterOptions { favorites, all }

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  var _showFavonly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ebuy',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (filterOptions value) {
              setState(() {
                if (value == filterOptions.favorites) {
                  _showFavonly = true;
                } else {
                  _showFavonly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(child: Text('Show favorites only'), value: filterOptions.favorites),
              PopupMenuItem(child: Text('Show all products'), value: filterOptions.all),
            ],
          )
        ],
      ),
      body: ProductsGrid(_showFavonly),
    );
  }
}
