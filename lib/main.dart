import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/orders.dart';
import 'provider/product_provider.dart';
import 'provider/cart.dart';
import 'config/routes.dart' as route;
import 'config/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const Ebuy());
}

class Ebuy extends StatelessWidget {
  const Ebuy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'ebuy',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        onGenerateRoute: route.controller,
        initialRoute: route.productOverviewPage,
      ),
    );
  }
}
