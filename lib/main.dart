import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/products_overview_page.dart';

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
    return MaterialApp(
      title: 'ebuy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: 'Lato',
      ),
      home: const ProductOverviewPage(),
    );
  }
}
