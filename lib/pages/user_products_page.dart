import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/routes.dart' as route;
import '../provider/product_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/left_drawer.dart';

class UserProductsPage extends StatelessWidget {
  const UserProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: const LeftDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                route.editProductPage,
                arguments: 'addProd',
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].id,
                productsData.items[i].title,
                productsData.items[i].imgURL,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
