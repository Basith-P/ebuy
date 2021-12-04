import 'package:flutter/material.dart';

import '../pages/products_overview_page.dart';
import '../pages/product_datail_page.dart';

const String productOverviewPage = 'prodOverview';
const String productDetailsPage = 'prodDetails';

Route<dynamic> controller(RouteSettings settings) {
  final arguments = settings.arguments;

  switch (settings.name) {
    case productOverviewPage:
      return MaterialPageRoute(builder: (_) => const ProductOverviewPage());
    case productDetailsPage:
      return MaterialPageRoute(builder: (_) => ProductDetailpage(data: arguments.toString()));
    default:
      throw ('This route does not exists');
  }
}
