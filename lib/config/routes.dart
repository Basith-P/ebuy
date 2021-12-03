import 'package:flutter/material.dart';

import '../pages/products_overview_page.dart';
import '../pages/product_datail_page.dart';

const String productOverviewPage = 'prodOverview';
const String productDetailsPage = 'prodDetails';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case productOverviewPage:
      return MaterialPageRoute(builder: (context) => const ProductOverviewPage());
    case productDetailsPage:
      return MaterialPageRoute(builder: (context) => const ProductDetailpage());
    default:
      throw ('This route does not exists');
  }
}
