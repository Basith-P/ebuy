import 'package:flutter/material.dart';

import '../pages/products_overview_page.dart';
import '../pages/product_datail_page.dart';
import '../pages/cart_page.dart';
import '../pages/orders_page.dart';
import '../pages/user_products_page.dart';
import '../pages/edit_product_page.dart';

const String productOverviewPage = 'prodOverview';
const String productDetailsPage = 'prodDetails';
const String cartPage = 'cart';
const String ordersPage = 'orders';
const String userProductsPage = 'userProducts';
const String editProductPage = 'editProduct';

Route<dynamic> controller(RouteSettings settings) {
  final arguments = settings.arguments;

  switch (settings.name) {
    case productOverviewPage:
      return MaterialPageRoute(builder: (_) => const ProductOverviewPage());
    case productDetailsPage:
      return MaterialPageRoute(builder: (_) => ProductDetailpage(data: arguments.toString()));
    case cartPage:
      return MaterialPageRoute(builder: (_) => const CartPage());
    case ordersPage:
      return MaterialPageRoute(builder: (_) => const OrdersPage());
    case userProductsPage:
      return MaterialPageRoute(builder: (_) => const UserProductsPage());
    case editProductPage:
      return MaterialPageRoute(builder: (_) => EditProductPage(arguments.toString()));
    default:
      throw ('This route does not exists');
  }
}
