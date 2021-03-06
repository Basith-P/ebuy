import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../provider/cart.dart';
import '../provider/product_provider.dart';
import '../config/routes.dart' as route;
import '../widgets/left_drawer.dart';

enum filterOptions { favorites, all }

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  var _showFavonly = false;
  var _isInit = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      context.read<Products>().fetchAndSetProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeftDrawer(),
      appBar: AppBar(
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
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () => Navigator.pushNamed(context, route.cartPage),
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(_showFavonly),
    );
  }
}
